class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :profile_picture_url

  attribute :token, if: :current_user_is_user?

  def current_user_is_user?
    current_user == object
  end
end
