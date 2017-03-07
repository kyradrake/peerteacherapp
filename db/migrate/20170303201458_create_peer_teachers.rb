class CreatePeerTeachers < ActiveRecord::Migration
  def change
    create_table :peer_teachers do |t|
      t.string :netID
      t.string :name
      t.string :courselist
      t.string :timelist
      t.string :image

      t.timestamps null: false
    end
  end
end
