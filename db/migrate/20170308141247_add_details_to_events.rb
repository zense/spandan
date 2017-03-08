class AddDetailsToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :vol_req, :integer
  end
end
