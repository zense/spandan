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
    #Modified to check for Single Event Registrations as well
    event = Event.find(event_id)
    if(event.nil?)
      errors.add(:base, "Event doesnt exist")
      return false
    end

    if(event.event_type==TEAM)
      team=self.teams.find_by_event_id(event_id)
      if !team.nil?
        return true
      end
    else
      if Registration.where(:user_id=> self.id,:event_id=>event_id, :isvalid=>true).count>0
        return true
      end
    end
    return false
  end

  def cancel_participation(event_id)
    # In case of a team event, user can cancel his/her participation if they have been added by mistake
    # First delete his teams_users entry

    msg = ''
    team = self.teams.find_by_event_id(event_id)
    registration = Registration.find_by_team_id(team.id)
    if team.nil?
      msg = "User has not participated in this event"
      return msg
    else
      Team.transaction do
        team.isvalid = false # Marking the team as invalid

        if !registration.nil? #Checking if the team has registered
          registration.isvalid = false # Marking the registration as invalid
          registration.save!
        end
        team.save!

        self.teams.delete(team.id) # delete from teams_users table
        #teams.delete(team.id)
      end
    end
  end

  def create_team(event_id, team_name)
    # Allows user to create a new team for any given event

    # Modify this to return id of created team
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
        t = Team.new(:name=>team_name, :event_id=>event_id, :parent_id=>self.id, :isvalid=>false)
        t.save!
        #t.users << self
        sql = "INSERT INTO teams_users (user_id, team_id, event_id) VALUES (#{self.id}, #{t.id}, #{event_id})"
        ActiveRecord::Base.connection.execute(sql)
        if t.users.count >= t.event.minimum_team_size # Handles the case where minimum team size is 1
          t.isvalid=true
          t.save!
          return t
        end
      end
    else
      msg = 'You have already registered for this event'
      puts msg
      errors.add(:base, msg)
      return false
    end
    return true
  end

  def register(event_id)
    #Users can register for single events using this function
    msg = ''
    event = Event.find(event_id)

    #Checking if the Event conditions are met
    if event.nil?
      msg = 'Event not found'
      puts msg
      errors.add(:base, msg)
      return false
    elsif event.event_type==TEAM
      msg = 'The given event is a team event.Please use a separate function.'
      puts msg
      errors.add(:base, 'The given event is a team event.Please use a separate function.')
      return false
    elsif event.last_date < Date.today
      msg = "Event Registration Over.Sorry"
      puts(msg)
      errors.add(:base, msg)
      return false
    end

    #Checking if the User conditions are met
    if !self.has_registered_for(event_id)
      # User hasn't already registered
      #TODO Check if isvalid is true for single events implicitly
      r = Registration.new(:user_id=>self.id, :event_id=>event_id,:isvalid=>true)
      r.save!
    else
      msg = 'You have already registered for this event'
      puts msg
      errors.add(:base, msg)
      return false
    end
  end

  def register_team(event_id,team_id)
    #Users can register for team events using this function.
    # Assuming they have already created Teams
    msg = ''
    event = Event.find(event_id)
    team = Team.find(team_id)
    #Checking if the Event conditions are met
    if event.nil?
      msg = 'Event not found'
      puts msg
      errors.add(:base, msg)
      return false
    elsif event.event_type!=TEAM
      msg = 'The given event is NOT a team event.Please use a separate function.'
      puts msg
      errors.add(:base, 'The given event is NOT a team event.Please use a separate function.')
      return false
    elsif event.last_date < Date.today
      msg = "Event Registration Over.Sorry"
      puts(msg)
      errors.add(:base, msg)
      return false
    end
    #Checking if team is valid
    if team.nil?
      msg = "Dude da fuq? No team bro"
      puts msg
      errors.add(:base,msg)
      return false
    elsif team.isvalid==false
      msg = "Team is invalid"
      puts msg
      errors.add(:base,msg)
      return false
    elsif (team.size < event.minimum_team_size or team.size > event.maximum_team_size)
      msg = "Team Size is Invalid"
      puts msg
      errors.add(:base,msg)
      return false
    end
    #Checking if the User conditions are met
    if !self.has_registered_for(event_id)
      # User hasn't already registered
      r = Registration.new(:user_id=>self.id, :event_id=>event_id,:team_id=>team_id, :isvalid=>true)
      r.save!
    else
      msg = 'You have already registered for this event'
      puts msg
      errors.add(:base, msg)
      return false
    end
  end

end
