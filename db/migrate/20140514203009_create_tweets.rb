class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text, null: false
      t.string :screen_name , null: false
      t.integer :tweet_id, null: false, limit: 8
      t.datetime :tweet_created_at, null: false

      t.timestamps
    end
  end
end
