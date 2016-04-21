# == Schema Information
#
# Table name: sprints
#
#  id         :integer          not null, primary key
#  end_date   :date
#  project_id :integer          not null
#

class Sprint < ActiveRecord::Base
  belongs_to :project
  has_many :stories
  has_many :issues

  validates :project, presence: true

  def duration
    (end_date - start_date).to_i
  end
end
