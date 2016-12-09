class Address < ActiveRecord::Base
  has_many :users
end
