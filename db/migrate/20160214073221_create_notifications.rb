class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :user
      t.string :message
      t.timestamps null: false
    end
  end
end
