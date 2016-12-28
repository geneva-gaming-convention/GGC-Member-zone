class Address < ActiveRecord::Base
  has_many :users
  belongs_to :locality
end
