class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :name
      t.string :email
      t.string :roll
      t.integer :tshirt_size

      t.timestamps null: false
    end
  end
end
