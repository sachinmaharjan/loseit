class Exercise < ActiveRecord::Base
  attr_accessible :activity, :duration_minutes, :user_id
  validates :activity, :length => { :maximum => 140, :minumum => 2 }
  validates_numericality_of :duration_minutes, :only_integer => true
  validates_inclusion_of :duration_minutes, :in => 1..999, :message => "can only be between 1 and 999"
  belongs_to :user
end