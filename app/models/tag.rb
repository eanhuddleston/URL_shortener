class Tag < ActiveRecord::Base
  attr_accessible :tag, :id

  has_many :urls_tags
  has_many :urls, :through => :url_tags

  def self.set_up
    Tag.create(:tag => "news")
    Tag.create(:tag => "sports")
    Tag.create(:tag => "entertainment")
    Tag.create(:tag => "programming")
    Tag.create(:tag => "lifestyle")
  end

  # def most_popular
  #
  #   Tag.find_by_sql(%Q{
  #
  #
  #       (select url_id
  #       from tags JOIN url_tags on tags.id = url_tags.tag_id
  #       JOIN urls ON url.id = url_tags.url_id
  #       GROUP BY tag_id)
  #     }
  #   })
  #
  #   UrlTag.where(:tag => "news").max(:url_id, :distinct => true)
  #   UrlTags group by tag_id, urlid
  #   order by count(url id)
  # end
end

