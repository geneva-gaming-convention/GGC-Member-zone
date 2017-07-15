class Event < ApplicationRecord
  # Relations
  has_many :registrations
  has_many :event_resources, :dependent => :delete_all
  has_many :event_packs, :dependent => :delete_all
  # ---------



  def are_all_resources_locales
    self.event_resources.each do |resource|
      if resource.remote
        return false
      end
    end
    return true
  end

  def get_all_played_games
    games = []
    self.event_resources.each do |resource|
      game = resource.game
      if game
        games.push(game)
      end
    end
    return games.uniq
  end

  def event_resources_by_game(game)
    self.event_resources.where(game: game)
  end
end
