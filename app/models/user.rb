class User < ActiveRecord::Base
  has_many :songs
  has_secure_password
end