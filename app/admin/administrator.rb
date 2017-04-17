ActiveAdmin.register Administrator do
  permit_params :first_name, :last_name,
                user_attributes: [:email, :password, :password_confirmation]
  config.sort_order = "updated_at_desc"
  
  form do |f|
    f.inputs "Admin" do
      f.input :first_name
      f.input :last_name
      f.input :test
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
      
  filter :first_name
  filter :last_name 

  index do
    selectable_column
    id_column 
    column :first_name
    column :last_name
    actions 
  end

end
