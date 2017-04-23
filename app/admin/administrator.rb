ActiveAdmin.register Administrator do
  #controller do 
  #  def index 
  #    params[:order] = "_asc"
  #    super
  #  end
  #end
  config.sort_order = "name_asc"
  permit_params :first_name, :last_name
                #:user_attributes => {
                #  :password 
                #  :password_confirmation   
                #  :meta_type 
                #}

  form do |f|
    f.inputs "Admin" do
      f.input :first_name
      f.input :last_name
      f.has_many :user do |user|
        user.input :email
        user.input :password
        user.input :password_confirmation
      end
    end
    f.actions
  end
end
