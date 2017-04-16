ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    link_to 'Populate Database', home_populate_db_path
  end # content
  
  action_item only: :index do
    link_to 'Populate Database', home_populate_db_path, :confirm => "Sure" 
  end
end