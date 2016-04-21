class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :issue_id, :user_id, :updated_at
end
