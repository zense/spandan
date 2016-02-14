class AddTshirtSizeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tshirt_size, :integer, :limit => 2
  end
end
