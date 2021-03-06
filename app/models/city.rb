class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, through: :neighborhoods
  has_many :reservations, through: :listings

  include Reserve

  def city_openings(from, to)
    openings(from, to)
  end


end
