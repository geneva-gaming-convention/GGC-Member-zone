class Event < ApplicationRecord
  # Relations
  has_many :registrations
  has_many :event_resources, :dependent => :delete_all
  # ---------

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
