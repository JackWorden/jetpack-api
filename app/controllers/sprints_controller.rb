class SprintsController < ApplicationController
  before_action :set_sprint, except: [:index, :create]

  def index
    render json: Project.find(params[:project_id]).sprints
  end

  def create
    sprint = Project.find(params[:project_id]).sprints.new(sprint_params)

    if sprint.save
      render json: sprint, status: :ok
    else
      render json: sprint, status: :bad_request
    end
  end

  def show
    render json: @sprint
  end

  def update
    if @sprint.update(sprint_params)
      render json: @sprint, status: :ok
    else
      render json: @sprint, status: :bad_request
    end
  end

  def destroy
    @sprint.destroy
    render nothing: true, status: :no_content
  end

  def activate
    @sprint.project.update(active_sprint_id: @sprint.id)
    @sprint.update(start_date: Date.today)
    render json: @sprint
  end

  def deactivate
    @sprint.project.update(active_sprint_id: nil)
    @sprint.update(start_date: nil)
    render json: @sprint
  end

  private

  def set_sprint
    @sprint = Sprint.find(params[:id])
  end

  def sprint_params
    params.require(:sprint).permit(:id, :end_date, :project_id)
  end
end
