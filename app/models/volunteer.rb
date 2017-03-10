class Volunteer < ActiveRecord::Base
	has_and_belongs_to_many :events
	validates :events , length: {minimum:1 , maximum:3 , message: ":Select minimium 1 and maximum 3"}
end