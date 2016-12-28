class Locality < ApplicationRecord
  has_many :addresses
  belongs_to :state
end
