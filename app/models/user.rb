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
    
    
end
