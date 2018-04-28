class UserCollection < ApplicationRecord
  belongs_to :user
  belongs_to :place
  enum collection_type: {want_to_go: 0, like: 1, checked_in: 2}
end
