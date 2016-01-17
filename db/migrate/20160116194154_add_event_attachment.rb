class AddEventAttachment < ActiveRecord::Migration
  def change
  	add_attachment(:events, :icon)
  end
end
