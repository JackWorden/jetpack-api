# == Schema Information
#
# Table name: issues
#
#  id          :integer          not null, primary key
#  project_id  :integer          not null
#  sprint_id   :integer
#  story_id    :integer
#  user_id     :integer
#  description :text
#

class Issue < ActiveRecord::Base
  belongs_to :project
  belongs_to :sprint
  belongs_to :story
  belongs_to :assignee, class_name: 'User'

  validates :description, presence: true
  validates :assignee, presence: true, if: :has_assignee?

  private

  def has_assignee?
    assignee_id.present?
  end
end
