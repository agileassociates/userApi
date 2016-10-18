class UserSerializer < ActiveModel::Serializer
  attributes :email, :auth_token, :user_profile
end
