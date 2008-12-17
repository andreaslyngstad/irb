class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :post_id
      t.string :author
      t.string :author_email
      t.text :content
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
