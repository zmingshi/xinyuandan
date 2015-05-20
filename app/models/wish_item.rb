class WishItem < ActiveRecord::Base
  #attr_accessible :title, :url, :mark, :flag
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 140 }
  validates :url, presence: true
  validates :mark, presence: true
  validates :user_id, presence: true
end
