# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20140314175508) do

  create_table "posts", :force => true do |t|
    t.string   "title",      :null => false
    t.text     "body",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username",                           :null => false
    t.string   "password_digest",                    :null => false
    t.string   "email",                              :null => false
    t.string   "auth_token",                         :null => false
    t.boolean  "activated",       :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "session_token"
    t.boolean  "admin",           :default => false
    t.string   "uid"
    t.string   "provider"
    t.string   "mobile"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["mobile"], :name => "index_users_on_mobile"
  add_index "users", ["provider"], :name => "index_users_on_provider"
  add_index "users", ["uid"], :name => "index_users_on_uid"
  add_index "users", ["username"], :name => "index_users_on_username"

end
