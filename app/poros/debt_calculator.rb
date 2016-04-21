class DebtCalculator
  def initialize(story)
    @story = story
    @sprint = story.sprint
  end

  def calculate
    [0, deficit].max
  end

  def expected_points
    (expected_points_per_day * days_passed).to_i
  end

  protected

  attr_accessor :story, :sprint

  private

  def days_passed
    Date.today - sprint.start_date
  end

  def expected_points_per_day
    (story.total_points / sprint.duration).to_f
  end

  def deficit
    expected_points - story.completed_points
  end
end
