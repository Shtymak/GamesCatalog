class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end
  def show
   @category = Category.find(params[:id])
   @products = @category.products
   @products =  @products.page(params[:page]).per($PERPAGE).with_attached_image.includes(:categories)
 end
end
