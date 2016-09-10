class Photo < ActiveRecord::Base
  after_initialize :default_values

  private
    def default_values
      self.url ||= "https://s3-us-west-1.amazonaws.com/truegrowthsf/photos/"
    end
end
