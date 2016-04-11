class SprintSerializer < ActiveModel::Serializer
  attributes :id, :project_id, :end_date
  has_many :stories
  has_many :issues
end
