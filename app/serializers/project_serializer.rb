class ProjectSerializer < ApplicationSerializer
  attributes :id, :name
  has_many :sprints
  has_many :stories
  has_many :issues
end
