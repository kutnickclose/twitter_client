class Pair < ActiveRecord::Base
  validates :first_screen_name, :second_screen_name, presence: true
  validates :first_screen_name, uniqueness: {scope: [:second_screen_name]}
  
  has_many :common_followings,
    class_name: "CommonPairFollowing",
    primary_key: :id,
    foreign_key: :pair_id
    
end
