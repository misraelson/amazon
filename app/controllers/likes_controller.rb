class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like          = current_user.likes.new
    review        = Review.find params[:review_id]
    @like.review   = review
      if @like.save
        redirect_to product_path(review.product), notice: "Liked!"
      else
        redirect_to product_path(review.product), alert: "Cannot Like!"
      end
  end

  def destroy
    @like = current_user.likes.find params[:id]
    @like.destroy
    redirect_to :back, notice: "Un-liked!"
  end
end
