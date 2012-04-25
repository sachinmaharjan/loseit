class Diet < ActiveRecord::Base
  attr_accessible :user_id, :items, :food_consumed, :serving, :calories, :sodium, :total_fruit_serving, :total_vegetable_serving, :water
  validates_numericality_of :items, :serving, :calories, :sodium, :total_fruit_serving, :total_vegetable_serving, :water, :only_integer => true
  validates_inclusion_of :items, :serving, :calories, :sodium, :total_fruit_serving, :total_vegetable_serving, :water, :in => 0..9999, :message => "can only be between 0 and 9999"
  validates :food_consumed, :length => { :maximum => 140, :minumum => 2 }
  belongs_to :user
end
