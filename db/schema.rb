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

ActiveRecord::Schema.define(:version => 20110207095335) do

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

  create_table "clients", :force => true do |t|
    t.integer  "user_id"
    t.string   "application_name"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "redirect_uri"
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
