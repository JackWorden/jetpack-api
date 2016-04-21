# == Schema Information
#
# Table name: stories
#
#  id          :integer          not null, primary key
#  project_id  :integer          not null
#  sprint_id   :integer
#  title       :string           not null
#  description :text
#

class Story < ActiveRecord::Base
  belongs_to :project
  belongs_to :sprint
  has_many :issues

  validates :title, presence: true

  def active_issues
    issues.where.not(status: Issue.statuses[:completed])
  end

  def completed_issues
    issues.where(status: Issue.statuses[:completed])
  end

  def completed_points
    completed_issues.sum(:points)
  end

  def total_points
    issues.sum(:points)
  end

  def expected_points
    debt_calculator.expected_points
  end

  def debt
    debt_calculator.calculate
  end

  private

  def debt_calculator
    @debt_calculator ||= DebtCalculator.new(self)
  end
end
