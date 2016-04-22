# == Schema Information
#
# Table name: projects
#
#  id               :integer          not null, primary key
#  name             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  team_id          :integer
#  active_sprint_id :integer
#

class Project < ActiveRecord::Base
  belongs_to :team

  has_many :sprints, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :issues, dependent: :destroy

  belongs_to :active_sprint, class_name: 'Sprint'

  validates :name, presence: true

  default_scope { order(name: :asc) }

  def issue_backlog
    Issue.where(sprint_id: nil, story_id: nil)
  end
end
