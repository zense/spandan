class AddPhoneNumberToUSers < ActiveRecord::Migration
  change_table(:users) do |t|
      t.string :phone_number, :default => ""
    end
end