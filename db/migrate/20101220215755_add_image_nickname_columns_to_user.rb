class AddImageNicknameColumnsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :nickname, :string
    add_column :users, :image, :string
  end

  def self.down
    remove_column :users, :nickname
    remove_column :users, :image 
  end
end
