class Team < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :event

  def add_user uid
    # Need to test
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
  end
end
