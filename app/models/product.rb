class Product < ApplicationRecord
  has_one_attached :image


  has_many :category_products
    has_many :categories, through: :category_products

  def photo
    if image.attached?
        image
    else
        "/nfd.jpg"
    end
  end


  def category_names=(names)
    category_products.delete_all
    names.split(',').map(&:strip).uniq.each do |category_name|
      category_id = Category.find_or_create_by(name: category_name.to_s.downcase).id
      CategoryProduct.create(product: self, category_id: category_id)
    end
  end

  def category_names
    categories.map(&:name).join(' , ')
  end
end
