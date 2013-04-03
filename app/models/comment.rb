class Comment < ActiveRecord::Base
  attr_accessible :user_id, :url_id, :comment

  has_many :user
  has_many :url
end