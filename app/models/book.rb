class Book < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :genre, presence: true, length: { maximum: 255 }
  validates :status, presence: true, length: { maximum: 255 }
  
  has_many :reviews
  
  has_many :mybooks
  has_many :readers, through: :mybooks,  source: :user
end
