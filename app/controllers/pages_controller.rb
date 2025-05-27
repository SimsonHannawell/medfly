class PagesController < ApplicationController
  def home
    @pharmacies = Pharmacy.all.includes(:products)
    @featured_products = Product.featured.limit(10)
  end
end
