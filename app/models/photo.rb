class Photo < ActiveRecord::Base
  after_initialize :default_values
  has_many :thumbs, dependent: :destroy

  private
    def default_values
      self.url ||= "https://d2udkby987yiki.cloudfront.net/"
      self.thumbs ||= Photo.thumbs
    end
end

