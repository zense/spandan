class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :async, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

	# Upcase rollnumber
	def roll_no=(val)
		write_attribute :roll_no, val.upcase
	end

	validates :student_type, inclusion: { in: ['mtech', 'imtech', 'alumni', 'msphd', 'staff'] }
	validates :roll_no, uniqueness: true, presence: true
	validates :name, presence: true
	validates :year_of_joining, inclusion: { in: ['2015','2014','2013','2012','2011','2010','2009','2008','2007','2006','2005','2004','2003','2002','2001','2000','1999']}
	validates :phone_number,:presence => true,
                 :numericality => true,
                 :length => { :minimum => 10, :maximum => 10 }

  has_one :volunteer_request # One user can make only one volunteer request
  has_and_belongs_to_many :teams
  has_many :registrations

  def has_registered_for(event_id)
		if self.teams.where(:event_id=>event_id, :isvalid=>true).count>0
			return true
		else
			return false
		end
	end

  def cancel_participation(event_id)
		# In case of a team event, user can cancel his/her participation if they have been added by mistake
		# First delete his teams_users entry
		msg = ''
		team = self.teams.find_by_event_id(event_id)
		if team.nil?
			msg = "User has not participated in this event"
			return msg
		else
			Team.transaction do
				team.isvalid = false # Marking the team as invalid
				team.save!
				self.teams.delete(team.id) # delete from teams_users table
			end
		end
	end

  def create_team(event_id, team_name)
		# Allows user to create a new team for any given event
		msg = ''
		event = Event.find(event_id)
		if event.nil?
			msg = 'Event not found'
			puts msg
			errors.add(:base, msg)
			return false
		elsif event.event_type!=TEAM
			msg = 'The given event is not a team event'
			puts msg
			errors.add(:base, 'The given event is not a team event')
			return false
		end

		if !self.has_registered_for(event_id)
			# the person hasn't already registered
			Team.transaction do
				t = Team.new(:name=>team_name, :event_id=>event_id, :parent_id=>self.id, :isvalid=>true)
				t.save!
				t.users << self
			end
		else
			msg = 'You have already registered for this event'
			puts msg
			errors.add(:base, msg)
			return false
		end
	end
end