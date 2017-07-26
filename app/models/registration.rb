class Registration < ApplicationRecord
  # Validation
  validates :user, :event, :event_resource, :event_pack, presence: true
  validates :user, :uniqueness => {:scope => [:event], :message => "can't be registered multiple times for the same event"}
  validates :team, :users_group, :presence => true, :if => "event_resource.game && event_resource.game.teambased?"
  validates :users_group, :presence => true, :if => "!event_resource.game"
  validates :is_a_player, inclusion: { in: [ true, false ] }
  validate :event_pack_must_be_in_event_resource
  # -----

  # Relations
  belongs_to :user
  belongs_to :event
  belongs_to :event_resource
  belongs_to :event_pack
  belongs_to :team
  belongs_to :users_group
  # -----

  before_create :is_still_free_slots, :is_user_ready_for_registration

  def event_pack_must_be_in_event_resource
    if self.event_pack && self.event_resource
      if self.event_resource.event_packs.count > 0
        # resources has special packs
        if self.event_pack != self.event_resource.event_packs.find_by(id: self.event_pack.id)
          # pack can't be used in this event resource
          message = "Nice try dude, this pack is not available for this tournament."
          errors.add(:base,message)
        end
      else
        # resources hasn't any special packs
        if self.event_pack != self.event.event_packs.find_by(id: self.event_pack.id) || self.event.event_packs.find_by(id: self.event_pack.id).event_resource
          # pack doesn't exist for this event or is linked to a special event_resource
          message = "Nice try dude, this pack is not available for this tournament."
          errors.add(:base,message)
        end
      end
    end
  end

  def is_still_free_slots
    if !self.event_resource.is_still_free_slots
      flash[:danger] = "An error occurred while registering, this tournament is full."
      redirect_to event_event_resource_path(self.event_resource.event, self.event_resource)
    end
  end

  def is_user_ready_for_registration
    if !self.user.is_ready_for_registration
      flash[:danger] = "An error occurred while registering, your GGC account is not yet ready for registration."
      redirect_to event_event_resource_path(self.event_resource.event, self.event_resource)
    end
  end

end
