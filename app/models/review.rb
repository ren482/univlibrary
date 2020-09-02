class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
 
  
#   文字数は今のところ適当。あと、ミニマムをつけてもいいしれん。
  validates :purpose, presence: true, length: { maximum: 255 }
  validates :sentences, presence: true, length: { maximum: 255 }
  validates :discovery, presence: true, length: { maximum: 255 }
  validates :summary, presence: true, length: { maximum: 255 }
  
 
end
