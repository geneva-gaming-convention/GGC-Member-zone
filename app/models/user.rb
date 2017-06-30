class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  # Validation
  validates :name, :lastname, :mail, :password, :password_confirmation, :salt, presence: true
  validates :name, :lastname, format: { without: /\@/ }
  validates :password, confirmation: true
  validates :password, :length => {:within => 6..40}
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
  # -----

  def encrypt_password(password)
    return Digest::SHA2.new(512).hexdigest(password+self.salt)
  end

  def authenticate(password)
    if Digest::SHA2.new(512).hexdigest(password+self.salt) == self.password
      true
    end
  end

  def has_already_game_provider(game_provider)
    self.game_accounts.each do |game_account|
      if game_account.game_provider == game_provider
        return true
      end
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
