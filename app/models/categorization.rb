class Categorization < ActiveRecord::Base
  set_table_name "categories_posts"
  belongs_to :category
  belongs_to :post
end
