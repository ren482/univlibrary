class User < ApplicationRecord
    before_save { self.email.downcase! }
    has_secure_password
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    validates :major, presence: true, length: { maximum: 50 }
    validates :academic_level, presence: true, length: { maximum: 50 }
    validates :profile_content, presence: true, length: { maximum: 255 }
end
