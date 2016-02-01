class Team < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :event

  # Lets a particular user add users to current team
  # Modify this to make sure that no more users can be added if team.size==team.event.maximum_team_size
  # Also modify to make sure the same user can't be added twice


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
