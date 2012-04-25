class CreateDiets < ActiveRecord::Migration
  def self.up
    create_table :diets do |t|
      t.integer :user_id
      t.integer :items
      t.string :food_consumed
      t.integer :serving
      t.integer :calories
      t.integer :sodium
      t.integer :total_fruit_serving
      t.integer :total_vegetable_serving
      t.integer :water

      t.timestamps
    end
  end

  def self.down
    drop_table :diets
  end
end
