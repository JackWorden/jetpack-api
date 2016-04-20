class StorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description
  belongs_to :sprint
  has_many :issues
end
