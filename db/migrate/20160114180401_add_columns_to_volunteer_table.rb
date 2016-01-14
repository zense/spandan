class AddColumnsToVolunteerTable < ActiveRecord::Migration
  def change
  	change_table(:volunteer_requests) do |t|
      t.integer :priority4
      t.integer :tshirt_size, :limit => 2
    end
  end
end
