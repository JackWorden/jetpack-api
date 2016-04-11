class TeamsController < ApplicationController
  before_action :set_team, except: [:create]

  def create
    api_response = API::TeamCreator.new(team_params, current_user).call
    render json: api_response.data, status: api_response.status
  end

  def show
    return render json: { errors: 'User has no team' }, status: :bad_request unless @team
    render json: @current_user.team
  end

  def destroy
    return render json: { errors: 'User has no team' }, status: :bad_request unless @team

    @team.destroy
    render text: 'Team successfully deleted'
  rescue => e
    render json: { errors: "Deletion failed: #{e.message}" }, status: :internal_server_error
  end

  private

  def set_team
    @team = current_user.team
  end

  def team_params
    params[:team].permit(:name)
  end
end
