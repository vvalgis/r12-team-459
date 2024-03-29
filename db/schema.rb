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

ActiveRecord::Schema.define(:version => 20121014231014) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true

  create_table "entries", :force => true do |t|
    t.integer  "user_id"
    t.string   "url"
    t.text     "description"
    t.string   "type"
    t.boolean  "shareable",   :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "title"
  end

  add_index "entries", ["shareable"], :name => "index_entries_on_shareable"
  add_index "entries", ["title"], :name => "index_entries_on_title"
  add_index "entries", ["type"], :name => "index_entries_on_type"
  add_index "entries", ["url"], :name => "index_entries_on_url"
  add_index "entries", ["user_id"], :name => "index_entries_on_user_id"

  create_table "user_entries", :force => true do |t|
    t.integer  "user_id"
    t.integer  "entry_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_entries", ["category_id"], :name => "index_user_entries_on_category_id"
  add_index "user_entries", ["entry_id"], :name => "index_user_entries_on_entry_id"
  add_index "user_entries", ["user_id"], :name => "index_user_entries_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",               :default => "", :null => false
    t.string   "encrypted_password",  :default => "", :null => false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "avatar_url"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
