class AddRequiredColumnsToUsers < ActiveRecord::Migration
  def change
  	change_table(:users) do |t|
      t.string :user_type, :default => ""
      t.string :year_of_joining, :default => ""
      t.string :student_type, :default => ""
      t.boolean :spoc, :default => false
    end
  end
end