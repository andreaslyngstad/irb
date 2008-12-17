class AddVideoguideToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :video_url, :string
    add_column :posts, :slag, :string
  end

  def self.down
    remove_column :posts, :video_url
    remove_column :posts, :slag
    
  end
end
