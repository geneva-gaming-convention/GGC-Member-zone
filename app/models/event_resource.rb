class EventResource < ApplicationRecord
  # Relations
  belongs_to :event
  belongs_to :game
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
    teams = ToornamentHelper.get_tournament_teams_participants(self.get_resource_remote_id)
    return teams
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
