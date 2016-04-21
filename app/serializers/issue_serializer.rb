class IssueSerializer < ActiveModel::Serializer
  attributes :id, :description, :project_id, :status, :sprint_id, :story_id, :assignee_id
  has_many :comments
  belongs_to :assignee
end
