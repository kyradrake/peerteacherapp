ActiveAdmin.register Administrator do
  #config.sort_order = 'name_asc'
  controller do 
    def create
      @administrator = Administrator.new( permitted_params[ :administrator ])
      if @administrator.save 
        redirect_to admin_administrator_path( @administrator )
      else
        render :new 
      end
    end
  end
  permit_params :first_name, :last_name, 
                user_attributes: [:id, :email, :password, :_destroy]
                
  form do |f|
    f.inputs do 
      f.input :first_name
      f.input :last_name
      f.input :notification, :as => :radio, :collection => [true, false], :label => "Notification?"
    end
    f.inputs do 
      f.has_many :user, allow_destroy: true do |usr|
        usr.input :email, required: true 
        usr.input :password, required: true
      end
    end
    f.actions
  end

end
