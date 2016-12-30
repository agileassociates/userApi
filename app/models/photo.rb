class Photo < ActiveRecord::Base
  after_initialize :default_values

  store_accessor :likes

  def likes
    self.likes
  end

  private
    def default_values
      self.url ||= "https://d2udkby987yiki.cloudfront.net/"
    end
end

