class ModifySchedule < ActiveRecord::Migration
  def change
    change_column :schedules, :party1, :string
    change_column :schedules, :party2, :string
  end
end
