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

ActiveRecord::Schema.define(:version => 20110404080450) do

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

  create_table "alarms", :force => true do |t|
    t.integer  "received_user_id", :null => false
    t.integer  "sent_user_id",     :null => false
    t.string   "type",             :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "bookmarks", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "foreign_key", :null => false
    t.string   "object",      :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "comments", :force => true do |t|
    t.integer  "post_id",                   :null => false
    t.integer  "user_id",                   :null => false
    t.string   "comment",                   :null => false
    t.integer  "sequence",   :default => 0
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

  create_table "messages", :force => true do |t|
    t.integer  "sent_user_id",     :null => false
    t.integer  "received_user_id", :null => false
    t.text     "message",          :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "post_tags", :force => true do |t|
    t.integer  "tag_id",     :null => false
    t.integer  "post_id",    :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id",                        :null => false
    t.integer  "store_id"
    t.integer  "activity_id"
    t.string   "post",                           :null => false
    t.integer  "image_count",   :default => 0
    t.integer  "like_count",    :default => 0
    t.integer  "comment_count", :default => 0
    t.integer  "tag_count",     :default => 0
    t.float    "lat",           :default => 0.0
    t.float    "lng",           :default => 0.0
    t.string   "from_where",                     :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "store_detail_infos", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.integer  "store_id",                  :null => false
    t.string   "note"
    t.integer  "sequence",   :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_food_logs", :force => true do |t|
    t.integer  "store_id",                  :null => false
    t.integer  "user_id",                   :null => false
    t.string   "action",                    :null => false
    t.string   "food_name",                 :null => false
    t.integer  "sequence",   :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "store_tags", :force => true do |t|
    t.integer  "tag_id",                    :null => false
    t.integer  "store_id",                  :null => false
    t.integer  "count",      :default => 0, :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "user_mileages", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "total_point",    :default => 0
    t.string   "grade"
    t.boolean  "special_user"
    t.boolean  "blacklist_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_tags", :force => true do |t|
    t.integer  "tag_id",                    :null => false
    t.integer  "user_id",                   :null => false
    t.integer  "count",      :default => 0, :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
