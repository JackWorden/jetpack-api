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

  def debt_calculator
    @debt_calculator ||= DebtCalculator.new(self)
  end
end
