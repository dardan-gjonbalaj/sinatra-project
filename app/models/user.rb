class User < ActiveRecord::Base
  has_many :songs
  has_secure_password
  validates_uniqueness_of :email
end