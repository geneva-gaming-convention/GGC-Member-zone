class User < ActiveRecord::Base
    attr_accessor :password_confirmation
    validates :name, :lastname, :mail, :password, :password_confirmation, :salt, presence: true
    validates :password, confirmation: true
    validates :mail, uniqueness: true
    before_create :change_password
    before_save :set_lowercase

    def encrypt_password(password)
        return Digest::SHA2.new(512).hexdigest(password+self.salt)
    end

    def authenticate(password)
        if Digest::SHA2.new(512).hexdigest(password+self.salt) == self.password
            true
        end
    end

    def set_lowercase
        self.name = self.name.downcase
        self.lastname = self.lastname.downcase
        self.mail = self.mail.downcase
    end

    def change_password(password=self.password)
        passwd=self.encrypt_password(password)
        self.password = passwd
        self.password_confirmation = passwd
    end

    def gen_token_and_salt
        self.token = loop do
            token = SecureRandom.hex(12)
            break token unless User.exists?(token: token)
        end
        self.salt = loop do
            salt = SecureRandom.hex(12)
            break salt unless User.exists?(salt: salt)
        end
    end
end