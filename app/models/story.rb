# == Schema Information
#
# Table name: stories
#
#  id         :integer          not null, primary key
#  project_id :integer          not null
#  sprint_id  :integer
#

class Story < ActiveRecord::Base
  belongs_to :project
  belongs_to :sprint
end
