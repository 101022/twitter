class Comment < ApplicationRecord
  belongs_to :user, class_name: "User", required: true
  belongs_to :tweet, class_name: "Tweet", required: true
  validates :comment, presence: true
end
