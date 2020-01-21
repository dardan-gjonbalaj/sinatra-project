class Song < ActiveRecord::Base
  belongs_to :users
  validates_uniqueness_of :title
end