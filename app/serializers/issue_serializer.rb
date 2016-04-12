class IssueSerializer < ActiveModel::Serializer
  attributes :id, :description, :project_id, :sprint_id, :story_id, :user_id
end
