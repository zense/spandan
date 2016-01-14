class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :Name
      t.text :Description
      t.text :Rules
      t.integer :Minimum_team_size
      t.integer :Maximum_team_size
      t.string :SPOC_of_the_event
      t.text :Contact_Details

      t.timestamps null: false
    end
  end
end
