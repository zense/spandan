class Event < ActiveRecord::Base
  has_many :volunteer_requests
end
