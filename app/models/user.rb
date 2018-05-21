class User < ApplicationRecord
    before_save { mail.downcase! }
    has_many :tweets

    has_secure_password
  
    def self.new_remember_token
      SecureRandom.urlsafe_base64
    end
  
    def self.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end
end
