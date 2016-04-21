# == Schema Information
#
# Table name: issues
#
#  id          :integer          not null, primary key
#  project_id  :integer          not null
#  sprint_id   :integer
#  story_id    :integer
#  assignee_id :integer
#  description :text
#

class Issue < ActiveRecord::Base
  belongs_to :project
  belongs_to :sprint
  belongs_to :story
  belongs_to :assignee, class_name: 'User'

  validates :description, presence: true
  validates :assignee, presence: true, if: :assigned?
  validates :points, numericality: { greater_than: 0 }

  private

  def assigned?
    assignee_id.present?
  end
end
