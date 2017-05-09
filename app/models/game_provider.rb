class GameProvider < ApplicationRecord
  # Relations
  has_many :game_accounts
  has_many :games
  # ---------
end
