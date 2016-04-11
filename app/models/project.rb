# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ActiveRecord::Base
  has_many :sprints
  belongs_to :active_sprint, class_name: 'Sprint'
  has_many :stories
  has_many :issues

  validates :name, presence: true
end
