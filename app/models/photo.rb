class Photo < ActiveRecord::Base
  after_initialize :default_values

  private
    def default_values
      self.url ||= "d2udkby987yiki.cloudfront.net/"
    end
end

