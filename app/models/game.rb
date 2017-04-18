class Game < ApplicationRecord
  # Relations
  has_many :event_resources
  # ---------

  def proper_shortname
    return self.shortname.gsub(/[^a-zA-Z0-9\-]/, '')
  end
end
