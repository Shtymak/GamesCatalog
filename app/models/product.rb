class Product < ApplicationRecord
  has_one_attached :image


  has_many :category_products
  has_many :categories, through: :category_products

  validates :name, presence: true, length: { minimum: 3, maximum:18 }
  validates :body, presence: true, length: { maximum: 400 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, only_integer: true }
  validates :size, presence: true, numericality: { greater_than_or_equal_to: 1 }

  def photo
    if image.attached?
        image
    else
        "/nfd.jpg"
    end
  end

  def set_image=(src)
    file = URI.parse(src).open
    image.attach(io: file, filename: name)
  rescue OpenURI::HTTPError => e
    pp e
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

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    sheet = spreadsheet.sheet(spreadsheet.sheets[0])
    pp header = sheet.row(sheet.first_row)
    (sheet.first_row + 1..sheet.last_row).each do |i|
      row = Hash[[header, sheet.row(i)].transpose]
      if row['id'].blank?
        product = Product.find_or_create_by(name: row['name'])
        row['id'] = product.id
      else
        product = Product.find_by(id: row['id'])
      end
      product.update(row)
    end
  end

  def self.open_spreadsheet(file)
      case File.extname(file.original_filename)
      when '.csv' then Roo::Csv.new(file.path)
      when '.xls' then Roo::Excel.new(file.path)
      when '.xlsx' then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
      end
    end
  end
