class StoriesController < ApplicationController
  before_action :set_story, except: [:create]

  def index
    render json: story_parent.stories
  end

  def create
    story = story_parent.stories.new(story_params)

    if story.save
      render json: story, status: :created
    else
      render json: story, status: :bad_request
    end
  end

  def show
    if @story
      render json: @story
    else
      render nothing: true, status: :bad_request
    end
  end

  def destroy
    if @story
      @story.destroy
      render nothing: true, status: :no_content
    else
      render nothing: true, status: :bad_request
    end
  end

  def update
    if @story.update(story_params)
      render json: @story, status: :ok
    else
      render json: @story, status: :bad_request
    end
  end

  private

  def story_parent
    project || sprint
  end

  def project
    Project.find(params[:project_id]) if params[:project_id]
  end

  def sprint
    Sprint.find(params[:sprint_id]) if params[:sprint_id]
  end

  def story_params
    params.require(:story).permit([:title, :description, :project_id, :sprint_id])
  end

  def set_story
    @story = Story.find_by_id(params[:id])
  end
end
