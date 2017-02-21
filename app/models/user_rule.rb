class UserRule < ApplicationRecord
  has_many :privileges
  has_many :users, through: :privileges
end
