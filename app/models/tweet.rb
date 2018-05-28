class Tweet < ApplicationRecord
  mount_uploader :picture, PictureUploader
  belongs_to :user, required: true
  has_many :comments, class_name: "Comment", dependent: :destroy
  validates :tweet, presence: true
end
