class CommonPairFollowing < ActiveRecord::Base
  validates :pair_id, :screen_name, :following_id, presence: true
  validates :pair_id, uniqueness: {scope: [:following_id]}
  
  belongs_to :pair,
    class_name: "Pair",
    foreign_key: :pair_id,
    primary_key: :id
  
end
