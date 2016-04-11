module API
  class TeamCreator
    def initialize(team_params, user)
      @team_params = team_params
      @user = user
    end

    def call
      return ErrorResponse.new('User already has a team', :bad_request) if user.team
      team = Team.create(team_params.merge(users: [user]))
      Response.new(team)
    rescue => e
      ErrorResponse.new("Encountered error: #{e.message}")
    end

    protected

    attr_reader :team_params, :user
  end
end
