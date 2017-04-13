ActiveAdmin.register Administrator do
  permit_params :first_name, :last_name  #what can be modified 
  config.sort_order = "updated_at_desc"
  
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
