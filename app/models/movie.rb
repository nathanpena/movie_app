class Movie < ActiveRecord::Base
  def self.ratings
    uniq.pluck(:rating)
  end

  def self.filter_ratings(ratings)
    where(rating: [ratings])
  end
end
