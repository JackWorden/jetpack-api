module API
  class TeamCreator
    def initialize(team_params, user)
      @team_params = team_params
      @user = user
    end

    def call
      return ApiResponse.new({ errors: 'User already has a team' }, :bad_request) if user.team
      team = Team.create(team_params.merge(users: [user]))
      ApiResponse.new(team)
    rescue => e
      ApiResponse.new({ errors: "Encountered error: #{e.message}" }, :internal_server_error)
    end

    protected

    attr_reader :team_params, :user
  end
end