class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favourite_products = current_user.favourite_products.all
  end

  def create
    favourite         = current_user.favourites.new
    product           = Product.find params[:product_id]
    favourite.product = product
    if favourite.save
      redirect_to product, notice: "Favourited!"
    else
      redirect_to product, alert: "Cannot Fave!"
    end
  end

  def destroy
    favourite         = current_user.favourites.find params[:id]
    favourite.destroy
    redirect_to product_path(product), notice: "Unfaved"
  end
  def product
    @product ||= Product.find params[:id]
  end
  def favourite
    @favourite ||= Favourite.find params[:id]
  end
end
