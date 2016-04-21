class CommentsController < ApplicationController
  before_action :set_comment, except: [:index, :create]
  before_action :set_issue, only: [:index, :create]

  def index
    render json: @issue.comments
  end

  def show
    render json: @comment, status: :ok
  end

  def create
    @comment = @issue.comments.new(comment_params)

    if @comment.save
      render json: @comment, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render nothing: true, status: :bad_request
    end
  end

  def destroy
    @comment.destroy
    render nothing: true, status: :no_content
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_issue
    @issue = Issue.find(params[:issue_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :issue_id)
  end
end
