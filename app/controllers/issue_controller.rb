class IssueController < ApplicationController
  before_action :set_issue, except: [:create]

  def index
    render json: Issue.all
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
    @issue = Issue.new(issue_params)
    if @issue.save
      render json: @issue, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:id, :name)
  end

  def set_issue
    @issue = Issue.find(params[:id])
  end
end
