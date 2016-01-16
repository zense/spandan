class AddEventAttachment < ActiveRecord::Migration
  def change
  	add_attachment(:events, :avatar)
  end
end
