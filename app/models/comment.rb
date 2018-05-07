class Comment < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  belongs_to :place
  belongs_to :parent, class_name: Comment.name, optional: true
  has_many :childrens, class_name: Comment.name,
    foreign_key: :parent_id, dependent: :destroy
end
