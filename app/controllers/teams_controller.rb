class TeamsController < ApplicationController
  before_action :set_team, except: [:create]

  def create
    response = API::TeamCreator.new(team_params, current_user).call
    render json: response.data, status: response.status
  end

  def show
    return no_team unless @team
    render json: @team, include: 'users'
  end

  def destroy
    return no_team unless @team

    @team.destroy
    render nothing: true, status: :no_content
  rescue => e
    render json: { errors: "Deletion failed: #{e.message}" }, status: :internal_server_error
  end

  def seed
    DataSeeder.new(@team, current_user).seed
    render nothing: true, status: :no_content
  end

  private

  def set_team
    @team = current_user.team
  end

  def team_params
    params.require(:team).permit(:name)
  end

  def no_team
    render json: { errors: 'User has no team' }, status: :bad_request
  end
end
