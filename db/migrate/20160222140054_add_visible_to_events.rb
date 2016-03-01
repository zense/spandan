class AddVisibleToEvents < ActiveRecord::Migration
  def change
    add_column :events, :visible, :boolean
  end
end
