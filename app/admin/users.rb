ActiveAdmin.register User, :as => 'Login User' do
  menu :priority => 2 
  permit_params :first_name, :last_name, :email, :password, :admin  #what can be modified 
  
  filter :first_name
  filter :last_name 
  filter :email
  
  index do
    selectable_column
    id_column 
    column :first_name
    column :last_name
    column :email
    column :admin
    actions 
  end
    
end
