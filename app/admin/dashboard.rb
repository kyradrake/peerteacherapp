ActiveAdmin.register_page "Dashboard" do
  
  #action_item :test do 
  #  Administrator.create( 
  #    :first_name => "Jama",
  #    :last_name => "Juno",
  #    :user_attributes => {
  #      :email => "Jamb123a@tamu.edu", 
  #      :password => "admin"
  #    }
  #  )
  #end
  
  
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # link_to 'Populate Database', home_populate_db_path
  end # content
  
  action_item only: :index do
    link_to 'Populate Database', home_populate_db_path, :confirm => "Sure?" 
   # link_to "Testing", admin_dashboard_test_path(test)
  end
end