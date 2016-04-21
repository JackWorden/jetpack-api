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

  enum status: { todo: 'todo', in_progress: 'in progress', completed: 'completed' }

  validates :description, presence: true
  validates :assignee, presence: true, if: :assigned?
  validates :sprint, presence: true, unless: :backlog?
  validates :points, numericality: { greater_than: 0 }

  before_save :reset_status, if: :backlog?

  scope :active, -> { where.not(status: statuses[:completed]) }
  scope :completed, -> { where(status: statuses[:completed]) }

  private

  def reset_status
    self.status = self.class.statuses[:todo]
  end

  def backlog?
    sprint_id.nil?
  end

  def assigned?
    assignee_id.present?
  end
end
