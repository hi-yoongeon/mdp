# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110210025356) do

  create_table "access_grants", :force => true do |t|
    t.string   "code"
    t.string   "access_token"
    t.string   "refresh_token"
    t.datetime "access_token_expires_at"
    t.integer  "user_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "store_id"
    t.integer  "like_id"
    t.integer  "bookmark_id"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attach_files", :force => true do |t|
    t.integer  "user_id"
    t.integer  "store_id"
    t.integer  "post_id"
    t.string   "filename"
    t.string   "webpath"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookmarks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "store_id"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.integer  "user_id"
    t.string   "application_name"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "redirect_uri"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "followed_user_id"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foods", :force => true do |t|
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", :force => true do |t|
    t.integer  "store_id"
    t.integer  "post_id"
    t.integer  "food_id"
    t.integer  "store_food_id"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "sent_user_id"
    t.integer  "received_user_id"
    t.text     "message"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notices", :force => true do |t|
    t.string   "subject"
    t.text     "content"
    t.string   "target"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id",                      :null => false
    t.integer  "store_id"
    t.integer  "activities_id"
    t.text     "post",                         :null => false
    t.integer  "image_count",   :default => 0, :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_foods", :force => true do |t|
    t.integer  "food_id"
    t.integer  "store_id"
    t.string   "food_name"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", :force => true do |t|
    t.integer  "user_id"
    t.integer  "region_id"
    t.string   "name"
    t.string   "tel"
    t.string   "address"
    t.string   "add_address"
    t.string   "website"
    t.text     "cover"
    t.string   "lat"
    t.string   "lng"
    t.integer  "bookmark_count"
    t.integer  "like_count"
    t.integer  "memo_count"
    t.integer  "image_count"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "tag"
    t.integer  "count"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_tests", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "userid"
    t.string   "hashed_password"
    t.string   "nick"
    t.string   "email"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
