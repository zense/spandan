class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.text :rules
      t.integer :minimum_team_size
      t.integer :maximum_team_size
      t.text :contact_details
      t.date :last_date
      t.integer :event_type
      t.timestamps null: false
    end
  end
end
