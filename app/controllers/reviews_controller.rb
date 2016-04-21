class ReviewsController < ApplicationController
  def create
    @product = Product.find params[:product_id]
    review_params = params.require(:review).permit(:body, :stars)
    @review  = Review.new review_params

    # this would assign the product_id for review
    @review.product = @product

    if @review.save
      # redirect to product show
      redirect_to product_path(@product), notice: "Thanks boo for the review"
    else
      flash[:alert] = "Review no savey"
      render "products/show"
    end
  end

  def destroy
    product = Product.find params[:product_id]
    review = Review.find params[:id]
    review.destroy
    redirect_to product_path(product), notice: "Review Deleted"
  end
end
