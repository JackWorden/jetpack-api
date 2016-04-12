class StoriesController < ApplicationController
  before_action :set_story, except: [:create]
  
  def create
    response = API::StoryCreator.new(story_params, current_user).call
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

  def update
    if @story.update(story_params)
      render json: @story, status: :ok
    else
      render json: @story, status: bad_request
    end
  end

  private

  def story_params
    params.require(:story).permit([:title, :description, :project_id, :sprint_id])
  end

  def set_story
    @story = Story.find(params[:id])
  end
end
