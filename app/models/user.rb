class User < ActiveRecord::Base
    attr_accessor :password_confirmation
    validates :name, :lastname, :mail, :password, :password_confirmation, :salt, presence: true
    validates :password, confirmation: true
    validates :mail, uniqueness: true
end
