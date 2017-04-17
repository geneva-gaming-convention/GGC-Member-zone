class EventResource < ApplicationRecord
  # Relations
  belongs_to :event
  belongs_to :game
  # ---------
  validates :event, :title, :start_at, presence: true
end
