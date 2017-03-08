class AddColumnToVolunteer < ActiveRecord::Migration
  def change
  	add_column :volunteers , :phone , :string
  end
end
