class SprintSerializer < ApplicationSerializer
  attributes :id, :project_id, :end_date, :active, :completed
  has_many :stories
  has_many :issues

  def active
    object.active?
  end

  def completed
    object.completed?
  end
end
