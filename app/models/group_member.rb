class GroupMember < ApplicationRecord
  belongs_to :users_group
  belongs_to :user

  # Validation
  validates :user, :uniqueness => {:scope => :users_group, :message => "you're already in this group genius 😆 !"}
  # -----

end
