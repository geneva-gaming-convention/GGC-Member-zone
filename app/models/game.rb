class Game < ApplicationRecord
  # Relations
  has_many :event_resources
  belongs_to :game_provider
  # ---------

  def proper_shortname
    return self.shortname.gsub(/[^a-zA-Z0-9\-]/, '')
  end
end
