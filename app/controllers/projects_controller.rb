class ProjectsController < ApplicationController
  before_action :find_project, only: %i(show update destroy)

  def index
    render json: Project.all, status: :ok
  end

  def update
    if @project.update_attributes(project_params)
      render json: @project, status: :ok
    else
      render json: @project, status: :bad_request
    end
  end

  def destroy
    @project.destroy
    render nothing: true, status: :no_content
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
    render json: @project, status: :ok
  end

  private

  def find_project
    @project = Project.find_by_id(params[:id])
    render nothing: true, status: :bad_request unless @project
  end

  def project_params
    params.require(:project).permit(:id, :name)
  end
end
