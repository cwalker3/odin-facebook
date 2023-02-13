class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :requestor, class_name: 'User'
end
