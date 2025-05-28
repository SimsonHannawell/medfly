module PharmaciesHelper
  def average_rating(pharmacy)
    return 0 if pharmacy.reviews.empty?

    total = pharmacy.reviews.sum(&:rating)
    (total.to_f / pharmacy.reviews.count).round(1)
  end

  def estimate_time(pharmacy)
    # You can customize this logic — using random for now
    mins = [15, 20, 25, 30, 35, 45, 60].sample
    "<span>⏱ Est. Time: #{mins} - #{mins + 5} mins</span>".html_safe
  end
end
