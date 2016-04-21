class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:new]
  #def new
  #  @product=Product.new
  #end

  def create
    product_params = params.require(:product).permit([:title,
                          :description, :price, :sale_price])
    @product       = Product.new(product_params)
    @product.user  = current_user

    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def index
    @products      = Product.all
  end

  def edit
      @product     = Product.find params[:id]
    end

  def show
    @favourite     = @product.favourite_for(current_user)
    @review        = Review.new
  end

  def update
    @product       = Product.find params[:id]
    product_params = params.require(:product).permit(:title,
                          :description, :price, :sale_price)
    if @product.update product_params
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find params[:id]
    @product.destroy
    redirect_to products_path
  end
private

  def find_product
    @product = Product.find params[:id]
  end

end
