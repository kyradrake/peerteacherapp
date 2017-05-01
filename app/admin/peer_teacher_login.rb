ActiveAdmin.register PeerTeacherLogin do
  #config.sort_order = 'name_asc'
  controller do 
    def create
      @peer_teacher_login = PeerTeacherLogin.new( permitted_params[ :peer_teacher_login ])
      if @peer_teacher_login.save 
        redirect_to admin_peer_teacher_login_path( @peer_teacher_login )
      else
        render :new 
      end
    end
  end
  permit_params :first_name, :last_name, :image, 
                user_attributes: [:id, :email, :password, :_destroy]


  index do
    selectable_column
    id_column 
    column "Image" do |product|
      image_tag product.image
    end
    column :first_name
    column :last_name, :sortable => ''
    actions 
  end
  
  form do |f|
    f.inputs do 
      f.input :first_name
      f.input :last_name
      f.input :image
    end
    f.inputs do 
      f.has_many :user, allow_destroy: true do |usr|
        usr.input :email
        usr.input :password
      end
    end
    f.actions
  end

end
