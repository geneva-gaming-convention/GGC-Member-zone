class Team < ApplicationRecord
  # Relations
  belongs_to :users_group
  belongs_to :game
  has_many :team_members, :dependent => :delete_all
  has_many :users, through: :team_members
  has_many :registrations, :dependent => :restrict_with_error
  # -----

  # Hooks
  # -----

  # Validations
  validates :name, :tag, :game, :users_group, presence: true
  validates :tag, uniqueness: true, length: {in: 2..4}
  validates :name, :uniqueness => {:scope => :game, :message => "this team's name is already used !"}
  # -----



  # ADD check payement for registrations
  def is_validated_for_event_resource(event_resource)
    if self.registration.where(event_resource: event_resource).count < self.game.nb_players
      return false
    end
    return true
  end

  def is_user_in_team(user)
    self.team_members.each do |team_member|
      if team_member.user == user
        return true
      end
    end
    return false
  end

  def get_proprietary
    self.team_members.each do |team_member|
      if team_member.is_creator
        return team_member.user
      end
    end
  end

  def is_proprietary(user)
    if user == self.get_proprietary
      return true
    else
      return false
    end
  end

  def to_select
    return [self.users_group.tag+" "+self.name, self.id]
  end

end
