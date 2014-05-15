class CreatePairs < ActiveRecord::Migration
  def change
    create_table :pairs do |t|
      t.string :first_screen_name, null: false
      t.string :second_screen_name, null: false

      t.timestamps
    end
  end
end
