class Comment < ApplicationRecord
  validates :comment, presence: true
  
  belongs_to :user, class_name: "User", required: true
  belongs_to :tweet, class_name: "Tweet", required: true
end
