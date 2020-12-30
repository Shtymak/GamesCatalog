class ProductsController < ApplicationController
  def show
    product
  end
  def new
  end

  def index
    @products = Product.all
  end
  def create
    @product = Product.new(product_params)
    if product.save
            redirect_to product
          else
            pp 'Error'
          end
  end
  private
  def product_params
    params.require(:product).permit(:name, :image,:body, :price, :size, :country)
  end
  def product
    @product ||= Product.find(params[:id])
  end
end
