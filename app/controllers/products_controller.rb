class ProductsController < ApplicationController

  def show
    product
  end

  def index
    @products = Product.order(:name)
    paginate
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
    filter
      @products = @products.where("name LIKE '%#{params[:search]}%' OR body LIKE '%#{params[:search]}%'")
    paginate
  end

  private

  def paginate
    @products = @products.page(params[:page]).per($PERPAGE).with_attached_image
  end

  def filter
    @filter = params[:filter]
    @products = @filter == '' ? Product.all : Product.where("price <= ?", @filter.to_i)
  end

  def product_params
    params.require(:product).permit(:name, :image,:body, :price, :size, :county, categories:[])
  end

  def product
    @product ||= Product.find(params[:id])
  end
end
