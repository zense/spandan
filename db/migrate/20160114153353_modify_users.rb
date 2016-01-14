class ModifyUsers < ActiveRecord::Migration
  def change
    add_column :users, :spoc_event_id, :integer, :default=>0
    add_column :users, :volunteer_event_id, :integer, :default=>0
  end
end
