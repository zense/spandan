class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :party1
      t.integer :party2
      t.integer :event_id
      t.string :schedule
      t.string :description
      t.string :result

      t.timestamps null: false
    end

  end
end
