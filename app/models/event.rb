class Event < ActiveRecord::Base
  has_many :volunteer_requests
  has_attached_file :icon, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: WEBLINK + "/assets/def.png"
  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\Z/
end
