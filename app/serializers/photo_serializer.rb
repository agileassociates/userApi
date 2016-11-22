class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :url, :count, :user_name
  attributes :likes, if :likes_condition?
end
