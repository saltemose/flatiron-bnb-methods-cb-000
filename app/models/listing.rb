class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  has_many :ratings, :through => :reviews

  validates :address, :listing_type, :title, :description, :price, :neighborhood_id, presence: true

  def average_review_rating
    sum = 0
    self.ratings.each do |rating|
      sum = rating + sum
    end
    sum/self.ratings.count
  end
end
