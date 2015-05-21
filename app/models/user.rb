class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :wish_items, dependent: :destroy

  has_many :friendships, :class_name => 'Friendship', :foreign_key => 'user_id',  dependent: :destroy
  has_many :friends, :through => :friendships, :source => :friend
 
  has_many :inverse_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id', dependent: :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_secure_password
end
