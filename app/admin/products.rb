ActiveAdmin.register Product do

   #See permitted parameters documentation:
  #https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  #Uncomment all parameters which should be permitted for assignment
  action_item :import, except: :import do
   link_to t('import'), admin_products_import_path
 end

 controller do
    def import; end

    def import_file
      Product.import(params[:file])
      redirect_to admin_products_path
    end
  end




  permit_params :name, :body, :price, :size, :county,:category_names, :image
  form do |f|
    f.inputs do
      f.input :name
      f.input :category_names
      f.input :body, as: :text
      f.input :price
      f.input :size
      f.input :county, label: "Country"
      f.input :image, as: :file
    end
  f.actions
end

show do
    attributes_table do
      row :name
      row :body
      row :price
      row :size
      row :county
      row :image do |object|
        image_tag object.photo, width:250
      end
    end
    panel 'Categories' do
      table_for product.categories do
        column :id
        column { |c| link_to c.name, admin_category_path(c.id) }
      end
    end
    active_admin_comments
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :body, :price, :size, :county]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
