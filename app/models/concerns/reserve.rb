
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

  class_methods do
    def highest_ratio_res_to_listings
      all.max_by do |ratio|
        if ratio.listings.count > 0 && ratio.reservations.count > 0
          ratio.reservations.count.to_f / ratio.listings.count.to_f
        else
          0
        end
      end
    end

    def most_res
      all.max do |a, b|
        a.reservations.count <=> b.reservations.count
      end
    end
  end
end
