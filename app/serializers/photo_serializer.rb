class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :url, :count, :user_name, :likes
end
