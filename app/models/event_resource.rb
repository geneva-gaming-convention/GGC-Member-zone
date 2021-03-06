class EventResource < ApplicationRecord
  # Relations
  belongs_to :event
  belongs_to :game
  has_many :registrations, :dependent => :restrict_with_error
  has_many :event_packs
  # ---------
  validates :event, :title, :start_at, presence: true

  def get_resource_remote_id
    begin
      return self.remote_url.split("/")[4]
    rescue
      raise "no available id for this resource"
    end
  end

  def get_teams
    teams = []
    if self.remote
      teams = ToornamentHelper.get_tournament_teams_participants(self.get_resource_remote_id)
    else
      self.registrations.each do |registration|
        registration_team = registration.team
        if registration_team
          unless teams.include?(registration_team)
            teams << registration_team
          end
        end
      end
    end
    return teams
  end

  def get_invited_teams
    teams = []
    if self.remote
      teams = ToornamentHelper.get_tournament_teams_participants(self.get_resource_remote_id)
    else
      self.registrations.where(invitation: true).each do |registration|
        registration_team = registration.team
        if registration_team
          unless teams.include?(registration_team)
            teams << registration_team
          end
        end
      end
    end
    return teams
  end

  def get_players
    players = []
    if self.remote
      players = ToornamentHelper.get_tournament_teams_participants(self.get_resource_remote_id)
    else
      self.registrations.each do |registration|
        player = registration.user
        unless players.include?(player)
          players << player
        end
      end
    end
    return players
  end

  def get_size
    size = 0
    if self.remote
      event_resource = ToornamentHelper.get_tournament_by_id(self.get_resource_remote_id)
      size = event_resource["size"]
    else
      if self.locked_quota != 0
        size = self.quota - self.locked_quota
      else
        size = self.quota
      end
    end
    return size
  end

  def get_validated_slots
    valid_partitipants = []
    if self.game && self.game.teambased
      registered_teams = self.get_teams
      registered_teams.each do |team_participating|
        if team_participating.is_validated_for_event_resource(self)
          valid_partitipants.push(team_participating)
        end
      end
    else
      self.registrations.where(team: nil).each do |player_registration|
        user = player_registration.user
        if user.is_validated_for_event_resource(self)
          valid_partitipants.push(user)
        end
      end
    end
    return valid_partitipants
  end

  def is_still_free_slots
    if get_validated_slots.count < self.get_size
      return true
    else
      return false
    end
  end

  def get_validated_invitation_slots
    valid_partitipants = []
    if self.game && self.game.teambased
      registered_teams = self.get_invited_teams
      registered_teams.each do |team_participating|
        if team_participating.is_validated_for_event_resource(self)
          valid_partitipants.push(team_participating)
        end
      end
    else
      self.registrations.where(team: nil).where(invitation: true).each do |player_registration|
        user = player_registration.user
        if user.is_validated_for_event_resource(self)
          valid_partitipants.push(user)
        end
      end
    end
    return valid_partitipants
  end

  def is_still_free_invitation_slots
    if get_validated_invitation_slots.count < self.locked_quota
      return true
    else
      return false
    end
  end

  def is_my_team_registered(team)
    if self.game && self.game.teambased
      self.get_teams.each do |registered_team|
        if team == registered_team
          return true
        end
      end
    end
    return false
  end

  def get_teams_with_members
    self.get_teams.each do |team|
      team["members"] = []
      mates = ToornamentHelper.get_tournament_teams_members(self.get_resource_remote_id, team["id"])["lineup"]
      if mates
        team["members"] = mates
      end
    end
  end
end
