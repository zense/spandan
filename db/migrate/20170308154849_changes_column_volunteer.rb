class ChangesColumnVolunteer < ActiveRecord::Migration
  def change
  	change_column :volunteers ,:tshirt_size, :string 
  end
end
