# == Schema Information
#
# Table name: sprints
#
#  id         :integer          not null, primary key
#  end_date   :date
#  project_id :integer          not null
#  start_date :date
#

class Sprint < ActiveRecord::Base
  default_scope -> { order(:end_date) }

  belongs_to :project
  has_many :stories
  has_many :issues

  before_destroy :reset_children_sprint_ids

  validates :project, presence: true
  validates :end_date, presence: true
  validate :end_date_must_be_in_future, if: :new_record?

  def duration
    (end_date - start_date).to_i
  end

  def active?
    project.active_sprint == self
  end

  def completed?
    end_date < Date.today
  end

  private

  def reset_children_sprint_ids
    stories.update_all(sprint_id: nil)
    issues.update_all(sprint_id: nil)
  end

  def end_date_must_be_in_future
    errors.add(:end_date, 'must be in the future') unless end_date > Time.zone.today
  end
end
