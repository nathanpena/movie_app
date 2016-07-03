class Movie < ActiveRecord::Base
  def self.ratings
    uniq.pluck(:rating)
  end
end
