class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  has_many :favorites
  has_many :likes_user, through: :favorites, source: :user
  
  has_many :notifications, dependent: :destroy
  
 
  
#   文字数は今のところ適当。あと、ミニマムをつけてもいいしれん。
  validates :purpose, presence: true, length: { maximum: 255 }
  validates :sentences, presence: true, length: { maximum: 255 }
  validates :discovery, presence: true, length: { maximum: 255 }
  validates :summary, presence: true, length: { maximum: 255 }
  
  def create_notification_like!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and review_id = ? and action = ?", current_user.id, user_id, id, "like"])
    
    if temp.blank?
      notification = current_user.active_notifications.new(
        review_id: id, 
        visited_id: user_id, 
        checked: "true",
        action: "like"
        )
        
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
    end
  end
  
end
