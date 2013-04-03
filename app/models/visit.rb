class Visit < ActiveRecord::Base
  attr_accessible :user_id, :url_id, :time

  belongs_to :user
  belongs_to :url
end