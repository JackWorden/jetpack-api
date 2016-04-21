class StorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description
  attribute :total_points
  attribute :expected_points, if: :in_active_sprint?
  attribute :debt, if: :in_active_sprint?

  belongs_to :sprint
  has_many :issues

  def in_active_sprint?
    return unless object.sprint
    object.sprint == object.project.active_sprint
  end
end
