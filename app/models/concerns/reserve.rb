
module Reserve
  extend ActiveSupport::Concern

  def openings(from, to)
    openings = []

    self.listings.each do |listing|
      if listing.reservations.none? {|r| r.checkin <= to.to_date and r.checkout >= from.to_date}
        openings << listing
      end
    end
    openings
  end

  def ratio_reservations_to_listings
    if listings.count > 0 && reservations.count > 0
      reservations.count.to_f / listings.count.to_f
    end
  end

  class_methods do
    def highest_ratio_res_to_listings
      self.all.max_by do |a|
        a.ratio_reservations_to_listings #<=> b.ratio_reservations_to_listings
      end
    end

    def most_res
      all.max do |a, b|
        a.reservations.count <=> b.reservations.count
      end
    end
  end
end
