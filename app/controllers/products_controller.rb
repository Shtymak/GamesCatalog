class ProductsController < ApplicationController

  def show
    product
  end

  def index
    @products = Product.order(:name).page(params[:page]).per($PERPAGE).with_attached_image
  end

  def create
    @product = Product.new(product_params)
    if product.save
            redirect_to product
          else
            pp 'Error'
          end
  end

  def search
      @search = params[:search]
      @products = Product.where("name LIKE '%#{params[:search]}%' OR body LIKE '%#{params[:search]}%'").page(params[:page]).per($PERPAGE).with_attached_image
    end

  private
  def product_params
    params.require(:product).permit(:name, :image,:body, :price, :size, :county, categories:[])
  end

  def product
    @product ||= Product.find(params[:id])
  end
end
