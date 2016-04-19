class IssuesController < ApplicationController
  before_action :set_issue, except: [:create, :index]

  def index
    render json: issue_parent.issues
  end

  def show
    render json: @issue, status: :ok
  end

  def update
    if @issue.update(issue_params)
      render json: @issue
    else
      render nothing: true, status: :bad_request
    end
  end

  def destroy
    @issue.destroy
    render nothing: true, status: :no_content
  end

  def create
    @issue = issue_parent.issues.new(issue_params)

    if @issue.save
      render json: @issue, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  def assignee
    if params[:user_id].present?
      @issue.update(assignee_id: params[:user_id])
    else
      @issue.update(assignee_id: nil)
    end

    render json: @issue.reload, status: :ok
  end

  private

  def issue_parent
    project || sprint || story
  end

  def project
    Project.find(params[:project_id]) if params[:project_id]
  end

  def sprint
    Sprint.find(params[:sprint_id]) if params[:sprint_id]
  end

  def story
    Story.find(params[:story_id]) if params[:story_id]
  end

  def issue_params
    params.require(:issue).permit(:id, :description, :project_id, :sprint_id, :story_id)
  end

  def set_issue
    @issue = Issue.find(params[:id])
  end
end
