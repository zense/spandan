class VolunteerRequest < ActiveRecord::Base
	validates :user_id, presence: true, uniqueness: true
	validates :tshirt_size, inclusion: { in: [1,2,3,4,5] }

  belongs_to :user
  belongs_to :event
end