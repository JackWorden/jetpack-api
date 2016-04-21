class IssueSerializer < ActiveModel::Serializer
  attributes :id, :description, :project_id, :sprint_id, :story_id, :assignee_id
  has_many :comments
end
