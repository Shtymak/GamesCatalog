ActiveAdmin.register Product do

   #See permitted parameters documentation:
  #https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  #Uncomment all parameters which should be permitted for assignment

  permit_params :name, :body, :price, :size, :county, :image
  form do |f|
    f.inputs do
      f.input :name
      f.input :body, as: :text
      f.input :price
      f.input :size
      f.input :county
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
        image_tag object.photo
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
