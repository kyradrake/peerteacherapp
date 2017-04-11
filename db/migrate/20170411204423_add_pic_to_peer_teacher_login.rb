class AddPicToPeerTeacherLogin < ActiveRecord::Migration
  def change
    add_column :peer_teacher_logins, :image, :string
  end
end
