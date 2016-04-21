class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def create
    product           = Product.find params[:product_id]
    favourite         = current_user.favourites.new
    favourite.product = product
    if favourite.save
      redirect_to product, notice: "Favourited!"
    else
      redirect_to product, alert: "Cannot Fave!"
    end
  end

  def destroy
    favourite = current_user.favourites.find params[:id]
    like.destroy
    redirect_to product, notice: "Unfaved"
  end
end
