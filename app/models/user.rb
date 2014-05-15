class User < ActiveRecord::Base
  validates :screen_name, presence: true
  validates :screen_name, uniqueness: true
  
  has_many :tweets,
    class_name: "Tweet",
    foreign_key: :screen_name,
    primary_key: :screen_name
    
end
