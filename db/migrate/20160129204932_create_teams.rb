class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :parent_id, null: false
      t.belongs_to :event
      t.string :name
      t.boolean :isvalid
      t.timestamps null: false
    end

    create_table :teams_users do |t|
      t.belongs_to :user
      t.belongs_to :team
      t.belongs_to :event
      t.timestamps
    end
  end
end
