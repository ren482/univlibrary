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
    
    has_many :reviews
    
    has_many :mybooks
    has_many :favbooks, through: :mybooks, source: :book
    
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: "Relationshp", foreign_key: "follow_id"
    has_many :followers, through: :reverses_of_relationship, source: :user
    
    has_many :favorites
    has_many :likes, through: :favorites, source: :review
    
    has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
    has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
    
    def addToBookshelf(other_book)
        self.mybooks.find_or_create_by(book_id: other_book.id)
    end
    
    def deleteFromBookshelf(other_book)
        mybook = self.mybooks.find_by(book_id: other_book.id)
        mybook.destroy if mybook
    end

    
    def added?(other_book)
        self.favbooks.include?(other_book)
    end
    
    def follow(other_user)
        unless self == other_user
            self.relationships.find_or_create_by(follow_id: other_user.id)
        end
    end
    
    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end
    
    def following?(other_user)
        self.followings.include?(other_user)
    end
    
    def like(other_review)
    
            self.favorites.find_or_create_by(review_id: other_review.id)
        
    end
    
    def unlike(other_review)
        favorite = self.favorites.find_by(review_id: other_review.id)
        favorite.destroy if favorite
    end
    
    def liked?(other_review)
        self.likes.include?(other_review)
    end
    
    def create_notification_follow!(current_user)
        temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, "follow"])
        if temp.blank?
            notification = current_user.active_notifications.new(
                visited_id: id, 
                checked: "true",
                action: "follow"
                )
                notification.save if notification.valid?
        end
    end
end
