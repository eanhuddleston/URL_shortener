class CreateUrl < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :long_url
      t.string :shortened_url
      t.integer :user_id
    end
  end
end
