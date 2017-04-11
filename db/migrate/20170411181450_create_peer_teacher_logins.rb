class CreatePeerTeacherLogins < ActiveRecord::Migration
  def self.up
    create_table :peer_teacher_logins do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
  end
  def self.down
    drop_table :peer_teacher_logins
  end
end
