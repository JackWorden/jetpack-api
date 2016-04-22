class StorySerializer < ApplicationSerializer
  attributes :id, :title, :description
  attribute :total_points
  attribute :completed_points
  attribute :expected_points, if: :in_active_sprint?
  attribute :debt, if: :in_active_sprint?

  belongs_to :sprint
  has_many :issues

  def in_active_sprint?
    return unless object.sprint
    object.sprint == object.project.active_sprint
  end

  link(:self) { story_path(object) }
  link(:issues) { story_issues_path(object) }
end
