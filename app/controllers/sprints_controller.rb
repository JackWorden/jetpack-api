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
    if @sprint
      render json: @sprint, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  def update
    if @sprint.update(sprint_params)
      render json: @sprint, status: :ok
    else
      render json: @sprint, status: :bad_request
    end
  end

  def destroy
    if @sprint
      @sprint.destroy
      render nothing: true, status: :no_content
    else
      render nothing: true, status: :bad_request
    end
  end

  def activate
    if @sprint
      @sprint.project.update(active_sprint_id: @sprint.id)
      render nothing: true, status: :no_content
    else
      render nothing: true, status: :bad_request
    end
  end

  def deactivate
    if @sprint
      @sprint.project.update(active_sprint_id: nil)
      render nothing: true, status: :no_content
    else
      render nothing: true, status: :bad_request
    end
  end

  private

  def set_sprint
    @sprint = Sprint.find_by_id(params[:id])
  end

  def sprint_params
    params.require(:sprint).permit(:id, :end_date, :project_id)
  end
end
