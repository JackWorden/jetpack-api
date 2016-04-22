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
  belongs_to :project
  has_many :stories
  has_many :issues

  before_destroy :reset_children_sprint_ids

  validates :project, presence: true

  default_scope { order(end_date: :desc) }

  def duration
    (end_date - start_date).to_i
  end

  private

  def reset_children_sprint_ids
    stories.update_all(sprint_id: nil)
    issues.update_all(sprint_id: nil)
  end
end
