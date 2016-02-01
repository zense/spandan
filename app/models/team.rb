class Team < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :event

  # Lets a particular user add users to current team
  # Modify this to make sure that no more users can be added if team.size==team.event.maximum_team_size
  # Also modify to make sure the same user can't be added twice
  def add_user uid
    # Need to test
    msg=""
    puts self.size.to_s
    event = Event.find(self.event_id)
    if self.size >= event.maximum_team_size
        msg="Maximum Team Size Reached"
        puts msg
        errors.add(:base, msg)
        return false
    end
    if uid.is_a? Integer
      user = User.find(uid)
    else
      # uid is email id of the person
      user = User.find_by_email(uid)
    end
    if user.nil?
      errors.add(:base, 'User with ' + uid.to_s + ' Not found')
      puts "User with " + uid.to_s + 'Not found'
      return false;
    else
      # Search if the user has already registered for the given event in some other team
      # Also check if that team registration has been declined
      if user.has_registered_for(self.event_id)
        errors.add(:base, 'User with ' + uid.to_s + ' has already registered for this event!')
        return false;

      else
        self.users << user # Add the user to the team
      end
    end
    puts self.size.to_s
    if self.size > event.minimum_team_size and self.size < event.maximum_team_size
      t=Team.find(self.id)
      t.isvalid=true
      t.save!
      msg="Size is " + self.size.to_s
      puts msg
    end
  end

  # Adds a entry into registrations table
  # Mark the registration as valid only if team is valid.
  # Also remember that if the team is marked invalid then corresponding registration sould also be marked invalid.
  # This might be a normalization issue but we have to get along with it due to some constraints.
  def register
  end

  # Returns size of the current team
  def size
    return self.users.count
  end
end
