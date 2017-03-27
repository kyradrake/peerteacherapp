class CreateOfficeHours < ActiveRecord::Migration
  def change
    create_table :office_hours do |t|
      t.integer :timeID
      t.string :email
      t.string :dow
      t.integer :sHour
      t.integer :sMin
      t.integer :eHour
      t.integer :eMin
      t.string  :change

      t.timestamps null: false
    end
  end
end
