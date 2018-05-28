class User < ApplicationRecord
    before_save { mail.downcase! }

    validates :name, presence: true
    validates :mail, presence: true
    validates :password, presence: true, confirmation: true

    has_many :tweets, class_name:  "Tweet", dependent: :destroy
    has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
    has_many :followings, class_name: "User", through: :active_relationships, source: :following
    has_many :followers, class_name: "User", through: :passive_relationships, source: :follower
    has_many :comments, class_name: "Comment", dependent: :destroy
    
    has_secure_password
  
    def self.new_remember_token
      SecureRandom.urlsafe_base64
    end
  
    def self.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end

    # ユーザーをフォローする
    def follow(other_user)
      active_relationships.create(following_id: other_user.id)
    end

    # ユーザーをアンフォローする
    def unfollow(other_user)
      active_relationships.find_by(following_id: other_user.id).destroy
    end

    # 現在のユーザーがフォローしてたらtrueを返す
    def following?(other_user)
      followings.include?(other_user)
    end
end
