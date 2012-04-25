class CreateExercises < ActiveRecord::Migration
  def self.up
    create_table :exercises do |t|
      t.integer :user_id
      t.string :activity
      t.integer :duration_minutes

      t.timestamps
    end
  end

  def self.down
    drop_table :exercises
  end
end
