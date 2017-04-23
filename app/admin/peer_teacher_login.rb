ActiveAdmin.register PeerTeacherLogin, :as => "Peer Teachers" do
  #controller do 
  #  def index 
  #    params[:order] = "name_asc"
  #    super
  #  end
  #end
  
  config.sort_order = "name_asc"
  permit_params :first_name, :last_name #what can be modified
  
  filter :first_name
  filter :last_name 

  #index :as => :grid do |teacher|
  #    div do
  #      a :href => admin_peer_teacher_path(teacher) do
  #        image_tag( teacher.image )
  #        end
  #    end
  #    a truncate(teacher.first_name + teacher.last_name), :href => admin_peer_teacher_path(teacher)
  #end
  
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

end
