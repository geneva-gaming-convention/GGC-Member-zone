class Registration < ApplicationRecord
  # Validation
  validates :user, :event, :event_resource, :event_pack, presence: true
  validates :user, :uniqueness => {:scope => [:event, :event_resource], :message => "can't be registered multiple times for the same event"}
  validates :team, :users_group, :presence => true, :if => "event_resource.game.teambased?"
  validates :is_a_player, inclusion: { in: [ true, false ] }
  # -----

  # Relations
  belongs_to :user
  belongs_to :event
  belongs_to :event_resource
  belongs_to :event_pack
  belongs_to :team
  belongs_to :users_group
  # -----
end
