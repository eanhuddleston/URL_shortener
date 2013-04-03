class Url < ActiveRecord::Base
  attr_accessible :long_url, :shortened_url, :user_id

  has_many :url_tags
  has_many :tags, :through => :url_tags
  belongs_to :user
  has_many :visits

  def self.make_short_url
    SecureRandom.urlsafe_base64(8)
  end

  def self.open(shortened_url, user_id)
    userurl = self.where(:shortened_url => shortened_url)[0]
    Visit.create(:user_id => user_id, :url_id => userurl.id,
        :time => Time.now)
    userurl.long_url
  end

  def self.add_tag(shortened_url, tag)
    url_id = self.where(:shortened_url => shortened_url)[0].id
    tag_id = Tag.where(:tag => tag)[0].id
    UrlTag.create(:url_id => url_id, :tag_id => tag_id)
  end

  def visits
    Visit.count(:conditions => "url_id = #{self.id}")
  end

  def distinct_visits
    Visit.where(:url_id => self.id).count(:user_id, :distinct => true)
  end

  def ten_min_visits
    now = Time.now
    past = now - 10 * 60
    Visit.where(:time => past..now).count
  end

  def self.find_links_for_user(user_id)
    Url.where(:user_id => user_id)
  end
end