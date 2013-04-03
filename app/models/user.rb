class User < ActiveRecord::Base
  attr_accessible :email, :username

  has_many :urls
  has_many :visits
  has_many :comments

  def create_url(url)
    Url.create(:long_url => url, :shortened_url => Url.make_short_url,
        :user_id => self.id)
  end

  def open(url)
    url_id = Url.where(:shortened_url => url)[0].id
    puts Comment.where(:url_id => url_id).map { |commentobj| commentobj.comment }
    Url.open(url, self.id)
  end

  def my_links
    Url.find_links_for_user(self.id)
  end

  def make_comment(url, comment)
    url_id = Url.where(:shortened_url => url)[0].id
    Comment.create(:url_id => url_id, :user_id => self.id,
        :comment => comment)
  end

end