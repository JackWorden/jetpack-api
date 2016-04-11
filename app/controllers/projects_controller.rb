class ProjectsController < ApplicationController
  before_action :set_project, only: %i(show update destroy)

  def index
    render json: Project.all, status: :ok
  end

  def update
    if @project.update(project_params)
      render json: @project, status: :ok
    else
      render json: @project, status: :bad_request
    end
  end

  def destroy
    if @project
      @project.destroy
      render nothing: true, status: :no_content
    else
      render nothing: true, status: :bad_request
    end
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      render json: @project, status: :ok
    else
      render json: @project, status: :bad_request
    end
  end

  def show
    if @project
      render json: @project, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  private

  def set_project
    @project = Project.find_by_id(params[:id])
  end

  def project_params
    params.require(:project).permit(:id, :name)
  end
end
