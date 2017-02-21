class Privilege < ApplicationRecord
  belongs_to :user_rule
  belongs_to :user
end
