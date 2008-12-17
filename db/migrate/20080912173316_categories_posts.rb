class CategoriesPosts < ActiveRecord::Migration
  def self.up
    create_table :categories_posts do |t|
    t.integer "category_id", :limit => 11, :null => false
    t.integer "post_id",     :limit => 11
    
    end
  add_index :categories_posts, :category_id
  add_index :categories_posts, :post_id
  end

  def self.down
    drop_table :categories_posts
  end
  
end
