class Registration < ApplicationRecord
  # Validation (goes ballistic)
  validates :user, :event, :event_resource, presence: true
  validates :event_pack, :presence  => true, :if => "!invitation"
  validates :event_pack, :presence  => true, :if => "invitation", on: :update
  validates :user, :uniqueness => {:scope => [:event], :message => "can't be registered multiple times for the same event"}
  validates :team, :users_group, :presence => true, :if => "!invitation && event_resource.game && event_resource.game.teambased?"
  validates :team, :users_group, :presence => true, :if => "invitation && event_resource.game && event_resource.game.teambased?", on: :update
  validates :users_group, :presence => true, :if => "!invitation && !event_resource.game"
  validates :users_group, :presence => true, :if => "invitation && !event_resource.game", on: :update
  validates :is_a_player, inclusion: { in: [ true, false ] }
  validate :event_pack_must_be_in_event_resource
  validate :is_still_free_slots, :on => :create
  validate :is_user_ready_for_registration
  # -----

  # Relations
  belongs_to :user
  belongs_to :event
  belongs_to :event_resource
  belongs_to :event_pack
  belongs_to :team
  belongs_to :users_group
  # -----

  # Callbacks
  after_save :paid_value_changed
  after_save :store_in_elastic
  after_destroy :delete_from_elastic
  # -----

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
    if self.team && !self.event_resource.is_my_team_registered(self.team)
      if self.invitation && !self.event_resource.is_still_free_invitation_slots
        message = "An error occurred while registering, this tournament is full, event for invitation."
        errors.add(:base,message)
      end
      if !self.invitation && !self.event_resource.is_still_free_slots
        message = "An error occurred while registering, this tournament is full."
        errors.add(:base,message)
      end
    end
  end

  def is_user_ready_for_registration
    if !self.user.is_ready_for_registration
      message = "An error occurred while registering, your GGC account is not yet ready for registration."
      errors.add(:base,message)
    end
  end

  def gen_token
    self.token = loop do
      token = SecureRandom.hex(24)
      break token unless User.exists?(token: token)
    end
  end

  def paid_value_changed
    should_send_it = self.paid_changed? && self.paid == true
    if should_send_it && self.user && self.event
      RegistrationMailer.send_ticket(self.user, self.event).deliver_now
    end
  end

  def store_in_elastic
    ElasticsearchHelper.store_in_elastic(self)
  end

  def delete_from_elastic
    ElasticsearchHelper.delete_from_elastic(self)
  end

  # Gen a registration hash with usefull data
  def to_hash
    registration_hash = {}
    registration_hash[:id] = self.id
    registration_hash[:created_at] = self.created_at
    registration_hash[:updated_at] = self.updated_at
    if self.user
      registration_hash[:user] = {
        "id" => self.user.id,
        "firstname" => self.user.name,
        "lastname" => self.user.lastname,
        "mail" => self.user.mail,
        "phone" => self.user.phone,
        "validated" => self.user.validated,
      }
    end
    if self.event
      registration_hash[:event] = {
        "id" => self.event.id,
        "name" => self.event.name,
        "shortname" => self.event.shortname
      }
    end
    if self.event_resource
      if self.event_resource.game
        registration_hash[:event_resource] = {
          "id" => self.event_resource.id,
          "name" => self.event_resource.title,
          "game" => {
            "id" => self.event_resource.game.id,
            "name" => self.event_resource.game.name
          }
        }
      else
        registration_hash[:event_resource] = {
          "id" => self.event_resource.id,
          "name" => self.event_resource.title
        }
      end
    end
    if self.event_pack
      registration_hash[:event_pack] = {
        "id" => self.event_pack.id,
        "name" => self.event_pack.name,
        "price" => self.event_pack.price
      }
    end
    if self.users_group
      registration_hash[:group] = {
        "id" => self.users_group.id,
        "name" => self.users_group.name,
        "tag" => self.users_group.tag
      }
    end
    if self.team
      registration_hash[:team] = {
        "id" => self.team.id,
        "name" => self.team.name,
        "tag" => self.team.tag
      }
    end
    registration_hash[:invitation] = self.invitation
    registration_hash[:invitation_used] = self.invitation_used
    registration_hash[:token] = self.token
    registration_hash[:is_a_player] = self.is_a_player
    registration_hash[:paid] = self.paid
    return registration_hash
  end

end
