class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.integer :timeID
      t.string :email
      t.string :dow
      t.integer :sHour
      t.integer :sMin
      t.integer :eHour
      t.integer :eMin
      t.string :date
      t.string :action
      t.string :msg
      t.integer :approved
      
      t.timestamps null: false
    end
  end
end
