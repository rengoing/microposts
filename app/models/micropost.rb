class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  has_many :favorites, foreign_key: 'micropost_id', dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  
  def favorite?(user)
    favorite_users.include?(user)
  end
end
