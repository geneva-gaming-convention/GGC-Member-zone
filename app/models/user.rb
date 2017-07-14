class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  # Validation
  validates :name, :lastname, :mail, :password, :password_confirmation, :salt, presence: true
  validates :name, :lastname, format: { without: /\@/ }
  validates :password, confirmation: true
  validates :password, :length => { minimum: 7 }
  validates :mail, uniqueness: true
  # -----

  # Hooks
  before_create :change_password
  before_save :set_lowercase
  # -----

  # Relations
  belongs_to :address
  has_many :registrations
  has_many :privileges
  has_many :user_rules, through: :privileges
  has_many :game_accounts
  has_many :group_members
  has_many :users_groups, through: :group_members
  has_many :team_members
  has_many :teams, through: :team_members
  # -----


  def has_already_game_provider(game_provider)
    self.game_accounts.each do |game_account|
      if game_account.game_provider == game_provider
        return true
      end
    end
    return false
  end

  def has_a_group
    if self.users_groups.count > 0
      return true
    else
      return false
    end
  end

  def has_a_team(game)
    self.teams.each do |team|
      if team.game == game
        return true
      end
    end
    return false
  end

  def get_teams_by_game(game)
    teams = []
    self.teams.each do |team|
      if team.game == game
        teams.push(team)
      end
    end
    return teams
  end

  def get_teams_select_by_game(game)
    teams = []
    self.teams.each do |team|
      if team.game == game
        teams.push(team.to_select)
      end
    end
    return teams
  end

  def get_manageable_teams
    teams = []
    self.users_groups.each do |group|
      group.teams.each do |team|
        teams.push(team)
      end
    end
    return teams
  end

  def get_manageable_teams_by_game(game)
    teams_by_games = []
    teams = get_manageable_teams
    teams.each do |team|
      if team.game == game
        teams_by_games.push(team)
      end
    end
    return teams_by_games
  end

  def encrypt_password(password)
    return Digest::SHA2.new(512).hexdigest(password+self.salt)
  end

  def authenticate(password)
    if encrypt_password(password) == self.password
      return true
    end
    return false
  end

  def set_lowercase
    self.name = self.name.downcase
    self.lastname = self.lastname.downcase
    self.mail = self.mail.downcase
  end

  def having_game_accounts
    if self.game_accounts.count > 0
      return true
    end
    return false
  end

  def change_password(password=self.password)
    passwd=self.encrypt_password(password)
    self.password = passwd
    self.password_confirmation = passwd
  end

  def gen_token_and_salt
    self.gen_token
    self.gen_salt
  end

  def gen_token
    self.token = loop do
      token = SecureRandom.hex(12)
      break token unless User.exists?(token: token)
    end
  end

  def gen_reset_token
    self.reset_token = loop do
      reset_token = SecureRandom.hex(12)
      break reset_token unless User.exists?(reset_token: reset_token)
    end
    self.reseted_at = DateTime.now
  end

  def gen_salt
    self.salt = loop do
      salt = SecureRandom.hex(12)
      break salt unless User.exists?(salt: salt)
    end
  end
end
