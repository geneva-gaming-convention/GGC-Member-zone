class GameAccount < ApplicationRecord
  # Validation
  validates :account_id, uniqueness: true
  # -----
  # Relations
  belongs_to :user
  belongs_to :game_provider
  # -----
end
