class TeamMember < ApplicationRecord
  # Relations
  belongs_to :team
  belongs_to :user
  # -----

  # Validation
  validates :user, :team, presence: true
  validates :user, :uniqueness => {:scope => :team, :message => "you're already in this team genius 😆 !"}
  # -----

end
