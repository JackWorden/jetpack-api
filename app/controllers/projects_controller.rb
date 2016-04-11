class ProjectsController < ApplicationController
  def index
    render json: Project.all, status: :ok
  end

  def update
    @project = Project.find(project_params[:id])
    if @project.update_attributes(project_params)
      render json: @project, status: :ok
    else
      render json: @project, status: :bad_request
    end
  end

  def destroy
    @project = Project.find_by_id(params[:id])
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
    @project = Project.find_by(id: params[:id])
    if @project
      render json: @project, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  private

  def project_params
    params.require(:project).permit(:id, :name)
  end
end
