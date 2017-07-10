class UsersGroup < ApplicationRecord
  # Relations
  has_many :group_members, :dependent => :delete_all
  has_many :users, through: :group_members
  # -----

  # Hooks
  before_create :change_password
  before_update :change_password
  # -----

  # Validations
  validates :password, :length => { minimum: 7 }
  validates :tag, length: {is: 4}, allow_blank: false
  validates :name, uniqueness: true
  # -----

  def get_proprietary
    self.group_members.each do |group_member|
      if group_member.is_creator
        return group_member.user
      end
    end
  end

  def is_proprietary(user)
    if user == self.get_proprietary
      return true
    else
      return false
    end
  end

  def is_user_already_group_member(user)
    self.group_members.each do |group_member|
      if group_member.user == user
        return true
      end
    end
    return false
  end

  ## Crypto stuff
  def encrypt_password(password)
    return Digest::SHA2.new(512).hexdigest(password+self.salt)
  end

  def authenticate(password)
    if encrypt_password(password) == self.password
      return true
    end
    return false
  end

  def change_password(password=self.password)
    passwd=self.encrypt_password(password)
    self.password = passwd
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
  # -----

end
