class EventPack < ApplicationRecord
  belongs_to :event
  belongs_to :event_resource
  has_many :registrations, :dependent => :restrict_with_error
end
