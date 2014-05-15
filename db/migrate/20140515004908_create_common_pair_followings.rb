class CreateCommonPairFollowings < ActiveRecord::Migration
  def change
    create_table :common_pair_followings do |t|
      t.integer :pair_id, null: false
      t.string :screen_name, null: false
      t.integer :following_id, null: false, limit: 8

      t.timestamps
    end
    
    add_index :common_pair_followings, :following_id
  end
end
