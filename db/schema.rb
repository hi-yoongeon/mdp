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

ActiveRecord::Schema.define(:version => 20110415051006) do

  create_table "access_grants", :force => true do |t|
    t.integer  "user_id",                                :null => false
    t.integer  "client_id",                              :null => false
    t.string   "access_token",                           :null => false
    t.string   "refresh_token"
    t.string   "code"
    t.datetime "access_token_expires_at"
    t.integer  "sequence",                :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", :force => true do |t|
    t.string   "user_name",                                  :null => false
    t.string   "user_id",                                    :null => false
    t.string   "object_type",                                :null => false
    t.string   "object_name",                                :null => false
    t.string   "object_id",                                  :null => false
    t.string   "object_complement_type", :default => "None", :null => false
    t.string   "object_complement_name"
    t.string   "object_complement_id"
    t.string   "action",                                     :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["sequence"], :name => "index_activities_on_sequence"

  create_table "alarms", :force => true do |t|
    t.integer  "received_user_id", :null => false
    t.integer  "sent_user_id",     :null => false
    t.string   "type",             :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alarms", ["sequence"], :name => "index_alarms_on_sequence"

  create_table "attach_files", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "store_id"
    t.integer  "post_id"
    t.string   "filename",   :null => false
    t.string   "fullpath",   :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attach_files", ["post_id"], :name => "index_attach_files_on_post_id"
  add_index "attach_files", ["store_id"], :name => "index_attach_files_on_store_id"

  create_table "bookmarks", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "foreign_key", :null => false
    t.string   "object",      :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookmarks", ["foreign_key"], :name => "index_bookmarks_on_foreign_key"
  add_index "bookmarks", ["object"], :name => "index_bookmarks_on_object"
  add_index "bookmarks", ["user_id"], :name => "index_bookmarks_on_user_id"

  create_table "clients", :force => true do |t|
    t.integer  "user_id",                         :null => false
    t.string   "application_name",                :null => false
    t.string   "client_id",                       :null => false
    t.string   "client_secret",                   :null => false
    t.string   "redirect_uri",                    :null => false
    t.integer  "sequence",         :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followings", :force => true do |t|
    t.integer  "following_user_id", :null => false
    t.integer  "followed_user_id",  :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followings", ["sequence"], :name => "index_followings_on_sequence"

  create_table "foods", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "like_count", :default => 0, :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "foreign_key", :null => false
    t.string   "object",      :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["foreign_key"], :name => "index_likes_on_foreign_key"
  add_index "likes", ["object"], :name => "index_likes_on_object"
  add_index "likes", ["user_id"], :name => "index_likes_on_user_id"

  create_table "messages", :force => true do |t|
    t.integer  "sent_user_id",     :null => false
    t.integer  "received_user_id", :null => false
    t.text     "message",          :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["received_user_id"], :name => "index_messages_on_received_user_id"
  add_index "messages", ["sent_user_id"], :name => "index_messages_on_sent_user_id"
  add_index "messages", ["sequence"], :name => "index_messages_on_sequence"

  create_table "mileage_stack_datas", :force => true do |t|
    t.integer  "user_id"
    t.string   "flag"
    t.integer  "point"
    t.integer  "from_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notices", :force => true do |t|
    t.string   "subject",    :null => false
    t.text     "content",    :null => false
    t.string   "target",     :null => false
    t.datetime "start_date", :null => false
    t.datetime "end_date",   :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notices", ["sequence"], :name => "index_notices_on_sequence"

  create_table "post_comments", :force => true do |t|
    t.integer  "post_id",                                        :null => false
    t.integer  "user_id",                                        :null => false
    t.string   "comment",                                        :null => false
    t.string   "from_where", :limit => 10, :default => "IPHONE", :null => false
    t.integer  "sequence",                 :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_comments", ["post_id"], :name => "index_post_comments_on_post_id"
  add_index "post_comments", ["sequence"], :name => "index_post_comments_on_sequence"

  create_table "post_tags", :force => true do |t|
    t.integer  "tag_id",     :null => false
    t.integer  "post_id",    :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_tags", ["post_id"], :name => "index_post_tags_on_post_id"
  add_index "post_tags", ["tag_id"], :name => "index_post_tags_on_tag_id"

  create_table "posts", :force => true do |t|
    t.integer  "user_id",                                           :null => false
    t.integer  "store_id"
    t.integer  "activity_id"
    t.string   "post",                                              :null => false
    t.integer  "image_count",                 :default => 0
    t.integer  "like_count",                  :default => 0
    t.integer  "comment_count",               :default => 0
    t.integer  "tag_count",                   :default => 0
    t.float    "lat",                         :default => 0.0
    t.float    "lng",                         :default => 0.0
    t.string   "from_where",    :limit => 10, :default => "IPHONE", :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["lat"], :name => "index_posts_on_lat"
  add_index "posts", ["lng"], :name => "index_posts_on_lng"
  add_index "posts", ["sequence"], :name => "index_posts_on_sequence"
  add_index "posts", ["store_id"], :name => "index_posts_on_store_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "regions", :force => true do |t|
    t.integer  "user_id",                     :null => false
    t.float    "lat_sw",     :default => 0.0, :null => false
    t.float    "lng_sw",     :default => 0.0, :null => false
    t.float    "lat_ne",     :default => 0.0, :null => false
    t.float    "lng_ne",     :default => 0.0, :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_detail_info_logs", :force => true do |t|
    t.integer  "store_id",                  :null => false
    t.integer  "user_id",                   :null => false
    t.string   "status",                    :null => false
    t.integer  "sequence",   :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "store_detail_info_logs", ["sequence"], :name => "index_store_detail_info_logs_on_sequence"

  create_table "store_detail_infos", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.integer  "store_id",                  :null => false
    t.string   "note"
    t.integer  "sequence",   :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "store_detail_infos", ["store_id"], :name => "index_store_detail_infos_on_store_id"

  create_table "store_food_logs", :force => true do |t|
    t.integer  "store_id",                  :null => false
    t.integer  "user_id",                   :null => false
    t.string   "action",                    :null => false
    t.string   "food_name",                 :null => false
    t.integer  "sequence",   :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "store_food_logs", ["sequence"], :name => "index_store_food_logs_on_sequence"

  create_table "store_foods", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "food_id",                       :null => false
    t.integer  "store_id",                      :null => false
    t.integer  "like_count", :default => 0,     :null => false
    t.boolean  "blind",      :default => false, :null => false
    t.integer  "sequence",   :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "store_foods", ["food_id"], :name => "index_store_foods_on_food_id"
  add_index "store_foods", ["store_id"], :name => "index_store_foods_on_store_id"

  create_table "store_tags", :force => true do |t|
    t.integer  "tag_id",                    :null => false
    t.integer  "store_id",                  :null => false
    t.integer  "count",      :default => 0, :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "store_tags", ["store_id"], :name => "index_store_tags_on_store_id"
  add_index "store_tags", ["tag_id"], :name => "index_store_tags_on_tag_id"

  create_table "store_urls", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.integer  "store_id",                  :null => false
    t.string   "url",                       :null => false
    t.integer  "sequence",   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", :force => true do |t|
    t.string   "name",                            :null => false
    t.integer  "reg_user_id"
    t.string   "tel"
    t.string   "address",                         :null => false
    t.string   "add_address"
    t.string   "website"
    t.text     "cover"
    t.float    "lat",            :default => 0.0
    t.float    "lng",            :default => 0.0
    t.integer  "tag_count",      :default => 0
    t.integer  "post_count",     :default => 0
    t.integer  "image_count",    :default => 0
    t.integer  "like_count",     :default => 0
    t.integer  "bookmark_count", :default => 0
    t.integer  "sequence",       :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stores", ["lat"], :name => "index_stores_on_lat"
  add_index "stores", ["like_count"], :name => "index_stores_on_like_count"
  add_index "stores", ["lng"], :name => "index_stores_on_lng"
  add_index "stores", ["reg_user_id"], :name => "index_stores_on_reg_user_id"

  create_table "tags", :force => true do |t|
    t.string   "tag",        :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_external_accounts", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "service",    :null => false
    t.text     "data",       :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_external_accounts", ["user_id"], :name => "index_user_external_accounts_on_user_id"

  create_table "user_mileages", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "total_point",    :default => 0
    t.string   "grade"
    t.boolean  "special_user"
    t.boolean  "blacklist_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_mileages", ["user_id"], :name => "index_user_mileages_on_user_id"

  create_table "user_tags", :force => true do |t|
    t.integer  "tag_id",                    :null => false
    t.integer  "user_id",                   :null => false
    t.integer  "count",      :default => 0, :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_tags", ["tag_id"], :name => "index_user_tags_on_tag_id"
  add_index "user_tags", ["user_id"], :name => "index_user_tags_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "userid",                             :null => false
    t.string   "hashed_password"
    t.string   "old_hashed_password"
    t.string   "salt",                               :null => false
    t.string   "nick",                               :null => false
    t.string   "email",                              :null => false
    t.string   "title"
    t.string   "intro"
    t.integer  "post_count",          :default => 0, :null => false
    t.integer  "tag_count",           :default => 0
    t.integer  "store_count",         :default => 0
    t.integer  "following_count",     :default => 0
    t.integer  "follower_count",      :default => 0
    t.integer  "sequence",            :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
