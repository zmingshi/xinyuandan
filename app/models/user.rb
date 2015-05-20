class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :wish_items, dependent: :destroy

  has_secure_password
end
