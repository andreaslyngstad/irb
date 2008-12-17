# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081214182116) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "des"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_posts", :force => true do |t|
    t.integer "category_id", :limit => 11, :null => false
    t.integer "post_id",     :limit => 11
  end

  add_index "categories_posts", ["category_id"], :name => "index_categories_posts_on_category_id"
  add_index "categories_posts", ["post_id"], :name => "index_categories_posts_on_post_id"

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.string   "author"
    t.string   "author_email"
    t.text     "content"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "messages", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "body"
    t.integer  "parent_id"
    t.string   "navlabel"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "proposed_parent_id", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level_id"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "author_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level_id"
    t.integer  "comments_count", :limit => 4, :default => 0, :null => false
    t.text     "lead"
    t.string   "video_url"
    t.string   "slag"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "first_name",                :limit => 100, :default => ""
    t.string   "last_name",                 :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
