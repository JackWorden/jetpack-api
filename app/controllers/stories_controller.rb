class StoriesController < ApplicationController
  before_action :set_story, only: [:show]
  
  def create
    response = StoryCreator.new(story_params, current_user)
    render json: response.data, status: response.status
  end

  def show
    render json: @story
  end

  def destroy
    @story.destroy
    render nothing: true, status: :no_content
  rescue => e
    render json: "Error: #{e.message}", status: :internal_server_error
  end

  private

  def story_params
    params.require(:story).permit([:title, :project_id, :sprint_id])
  end

  def set_story
    @story = Story.find(params[:id])
  end
end
