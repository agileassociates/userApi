class Photo < ActiveRecord::Base
  after_initialize :default_values

  def likes_condition?
    true if self.likes != NULL
  end

  private
    def default_values
      self.url ||= "https://d2udkby987yiki.cloudfront.net/"
    end
end

