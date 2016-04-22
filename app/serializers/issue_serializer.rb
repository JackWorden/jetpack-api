class IssueSerializer < ApplicationSerializer
  attributes :id, :description, :project_id, :status, :sprint_id,
             :story_id, :assignee_id, :points, :order
  has_many :comments
  belongs_to :assignee
end
