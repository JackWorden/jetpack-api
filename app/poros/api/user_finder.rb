module API
  class UserFinder
    def initialize(token)
      @token = token
    end

    def call
      if token
        ApiResponse.new(user_from_id)
      else
        ApiResponse.new({ errors: 'No access token given' }, :bad_request)
      end
    end

    protected

    attr_reader :token

    private

    def user_from_id
      user = User.find_by_github_id(github_id)
      return user if user
      User.create(github_id: github_id, name: octokit.user[:login])
    end

    def github_id
      octokit.user[:id]
    end

    def octokit
      @octokit ||= Octokit::Client.new(access_token: token)
    end
  end
end