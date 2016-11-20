class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :url, :count, :user_name, has_many :thumbs
end
