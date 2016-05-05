class LikesController < ApplicationController
  before_action :authenticate_user!


  def create
    @like           = current_user.likes.new
    @review         = Review.find params[:review_id]
    @like.review    = @review
    @product        = params[:product_id]
    respond_to do |format|
      if @like.save
        format.html { redirect_to product_path(@review.product), notice: "Liked!" }
        format.js { render }
      else
        format.html { redirect_to product_path(@review.product), alert: "Already Liked!" }
        format.js { render js: "alert('Can\'t like!');" }
      end
    end
  end

  def destroy
    @like = current_user.likes.find params[:id]
    @like.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: "Un-liked!" }
      format.js { render }
    end
  end

private

def review
  @review ||= Review.find params[:question_id]
end

def like
  @like ||= Like.find params[:id]
end

end
