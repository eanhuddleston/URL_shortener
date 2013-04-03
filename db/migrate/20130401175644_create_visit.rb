class CreateVisit < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.datetime :time
      t.integer :user_id
      t.integer :url_id
    end
  end
end
