class Event < ApplicationRecord
  # Relations
  has_many :registrations
  has_many :event_resources
  # ---------
end
