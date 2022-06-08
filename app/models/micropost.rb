class Micropost < ApplicationRecord
  belongs_to :user
  
  has_many :favorites
  has_many :favorite_user, through: :favorites, source: :user_id
  
  validates :content, presence: true, length: {maximum: 255}
end
