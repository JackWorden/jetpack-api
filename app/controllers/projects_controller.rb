class ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :create]

  def index
    render json: Project.all, status: :ok
  end

  def show
    if @project
      render json: @project,
             include: %w(sprints sprints.stories sprints.issues sprints.stories.issues)
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

  def update
    if @project.update(project_params)
      render json: @project, status: :ok
    else
      render json: @project.reload, status: :bad_request
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

  def issue_backlog
    if @project
      render json: @project.issue_backlog
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
