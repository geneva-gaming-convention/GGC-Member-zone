class EventPack < ApplicationRecord
  belongs_to :event
  belongs_to :event_resource
  has_many :registrations
end
