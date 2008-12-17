class AddLevelIdToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :level_id, :integer
    add_column :pages, :level_id, :integer
  end

  def self.down
    remove_column :posts, :level_id
    remove_column :pages, :level_id
  end
end
