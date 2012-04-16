class AddMemberIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :member_id, :string
  end

  def self.down
    remove_column :users, :member_id
  end
end
