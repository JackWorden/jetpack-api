module API
  class GithubAuthenticator
    def initialize(session_code)
      @session_code = session_code
    end

    def user
      return nil unless github_user

      User.where(github_id: github_user.id).first_or_create.tap do |user|
        user.github_access_token = access_token
        user.name = github_user.name.presence || github_user.login.presence
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
