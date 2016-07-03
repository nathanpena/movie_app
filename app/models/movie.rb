class Movie < ActiveRecord::Base
  def self.ratings
    uniq.pluck(:rating).sort
  end
end
