class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :url_id
    end
  end
end
