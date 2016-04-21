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
  has_many :issues, dependent: :destroy

  validates :title, presence: true

  before_save :assign_to_project

  default_scope { order(title: :asc) }

  def completed_points
    issues.completed.sum(:points)
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

  def assign_to_project
    self.project = sprint.project if project.nil?
  end

  def debt_calculator
    @debt_calculator ||= DebtCalculator.new(self)
  end
end
