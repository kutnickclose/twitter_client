class Tweet < ActiveRecord::Base
  validates :text, :screen_name, :tweet_id, :tweet_created_at, presence: true
  validates :tweet_id, uniqueness: true
  
  belongs_to :user,
    class_name: "User",
    foreign_key: :screen_name,
    primary_key: :screen_name
  
  
end
