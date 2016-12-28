class State < ApplicationRecord
  has_many :localities
  belongs_to :country
end
