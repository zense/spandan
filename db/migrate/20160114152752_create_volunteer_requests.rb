class CreateVolunteerRequests < ActiveRecord::Migration
  def change
    create_table :volunteer_requests do |t|
      t.belongs_to :user
      t.integer :priority1
      t.integer :priority2
      t.integer :priority3
      t.boolean :approved, :default=>false
      t.integer :event_id, :default=>0
      t.timestamps null: false
      t.datetime :approved_on, :null=>true
      t.integer :approved_by, :null=>true
    end
  end
end
