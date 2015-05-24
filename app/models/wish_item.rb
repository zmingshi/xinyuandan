class WishItem < ActiveRecord::Base
  #attr_accessible :title, :url, :mark, :flag
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  
  validates :title, presence: true, length: { maximum: 140 }
  validates :url, presence: true
  validates :mark, presence: true
  validates :user_id, presence: true
end
