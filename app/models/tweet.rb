class Tweet < ApplicationRecord
  validates :tweet, presence: true
  
  mount_uploader :picture, PictureUploader

  belongs_to :user, required: true
  has_many :comments, class_name: "Comment", dependent: :destroy
end
