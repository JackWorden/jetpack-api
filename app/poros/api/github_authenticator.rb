module API
  class GithubAuthenticator
    def initialize(session_code)
      @session_code = session_code
    end

    def user
      return nil unless github_user

      find_or_create_user.tap do |user|
        Team.where(id: user.team_id).first_or_create do |team|
          team.update(name: 'Zebras Playing Bingo')
          user.update(team: team)
        end
      end
    end

    def find_or_create_user
      User.where(github_id: github_user.id).first_or_initialize.tap do |user|
        user.github_access_token = access_token
        user.name = github_user.name || github_user.login
        user.profile_picture_url = github_user.avatar_url
        user.save
      end
    end

    private

    def github_user
      @github_user ||= Octokit::Client.new(access_token: access_token).user
    rescue
      nil
    end

    def access_token
      return @access_token if @access_token

      result = RestClient.post(login_url, login_opts, accept: :json)

      @access_token = JSON.parse(result)['access_token']
    end

    def login_url
      'https://github.com/login/oauth/access_token'
    end

    def login_opts
      {
        client_id: ENV.fetch('GITHUB_CLIENT_ID'),
        client_secret: ENV.fetch('GITHUB_CLIENT_SECRET'),
        code: @session_code
      }
    end
  end
end
