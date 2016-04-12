module API
  class StoryCreator
    def initialize(story_params, user)
      @story_params = story_params
      @user = user
    end

    def call
      story = Story.create(story_params)
      Response.new(story)
    rescue => e
      ErrorResponse.new("Encountered error: #{e.message}")
    end

    protected

    attr_reader :story_params, :user
  end
end
