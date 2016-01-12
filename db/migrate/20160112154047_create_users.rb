class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :roll_no, null: false
      t.boolean :volunteer, :default => false
      t.timestamps null: false
      # Please note that this migration does not contain the email field
      # so that you can easily add devise to this table using the given link:
      # https://github.com/plataformatec/devise/wiki/How-To:-Change-an-already-existing-table-to-add-devise-required-columns
    end
  end
end
