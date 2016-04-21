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
  has_many :stories, dependent: :destroy
  has_many :issues, dependent: :destroy

  validates :project, presence: true

  default_scope { order(end_date: :desc) }

  def duration
    (end_date - start_date).to_i
  end
end
