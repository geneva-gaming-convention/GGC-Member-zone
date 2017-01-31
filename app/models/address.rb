class Address < ActiveRecord::Base
  has_many :users
  belongs_to :locality

  def to_string
    locality = self.locality
    state = locality.state
    country = state.country
    full_addr = self.street+" "+self.number.to_s+" "+locality.postal_code.to_s+" "+locality.name+" "+state.name+" "+country.name
    return full_addr
  end
end
