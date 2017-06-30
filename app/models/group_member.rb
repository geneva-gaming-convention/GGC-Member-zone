class GroupMember < ApplicationRecord
  belongs_to :users_group
  belongs_to :user
end
