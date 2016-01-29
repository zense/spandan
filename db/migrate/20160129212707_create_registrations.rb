class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.belongs_to :user, null: true
      t.belongs_to :team, null: true
      t.belongs_to :event, null: false
      t.boolean :isvalid, :default=> true
      t.timestamps null: false
    end
  end
end
