class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def create
    review_params = params.require(:review).permit(:body, :stars)
    @product = Product.find params[:product_id]
    @review  = Review.new review_params
    # this would assign the product_id for review
    @review.product = @product
    respond_to do |format|
      if @review.save
        # redirect to product show
        format.html { redirect_to product_path(@product), notice: "Thanks boo for the review" }
        format.js   { render :create_success }
      else
        format.html { render "product/show" }
        format.js   { render :create_failure }
      end
    end
  end

  def show
    @like = @review.like_for(current_user)
  end

  def destroy
    product = Product.find params[:product_id]
    @review = Review.find params[:id]
    @review.destroy
    respond_to do |format|
      format.html {redirect_to product_path(product), notice: "Review Deleted" }
      format.js { render }
    end
  end
end
