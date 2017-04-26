class AddEmailNotificationToAdministrator < ActiveRecord::Migration
  def change
    add_column :administrators, :notification, :boolean, default: true 
  end
end
