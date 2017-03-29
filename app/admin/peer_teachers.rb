ActiveAdmin.register PeerTeacher do
    menu :priority => 3 
    permit_params :name
    
    config.batch_actions = false  #remove default destroy bash option 
    
    filter :netID, label: 'Email'
    filter :name 
    
    index :as => :grid do |teacher|
        div do
          a :href => admin_peer_teacher_path(teacher) do
            image_tag( teacher.image )
          end
        end
        a truncate(teacher.name), :href => admin_peer_teacher_path(teacher)
  end

end
