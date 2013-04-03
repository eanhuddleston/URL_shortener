class UrlTags < ActiveRecord::Migration
  def change
    create_table :url_tags do |t|
      t.integer :url_id
      t.integer :tag_id
    end
  end
end
