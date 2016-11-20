class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :url, :count, :user_name, :user_profile
end
