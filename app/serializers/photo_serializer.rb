class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :url
end
