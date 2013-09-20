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

ActiveRecord::Schema.define(:version => 20130920202300) do

  create_table "cards", :force => true do |t|
    t.string   "last_four"
    t.datetime "expires"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "card_type"
    t.string   "name"
    t.string   "stripe_token"
    t.string   "stripe_id"
    t.integer  "user_id"
  end

  create_table "invoices", :force => true do |t|
    t.string   "description"
    t.string   "user_id"
    t.string   "card_id"
    t.string   "store_id"
    t.integer  "amount"
    t.string   "status"
    t.string   "currency"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "payments", :force => true do |t|
    t.string   "ip"
    t.string   "country"
    t.datetime "local_time"
    t.integer  "card_id"
    t.integer  "user_id"
    t.integer  "store_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "invoice_id"
    t.string   "stripe_id"
  end

  create_table "stores", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "rate"
    t.string   "authentication_token"
  end

  add_index "stores", ["email"], :name => "index_stores_on_email", :unique => true
  add_index "stores", ["reset_password_token"], :name => "index_stores_on_reset_password_token", :unique => true

  create_table "subscriptions", :force => true do |t|
    t.string   "description"
    t.string   "user_id"
    t.string   "card_id"
    t.string   "store_id"
    t.integer  "amount"
    t.datetime "frequency"
    t.datetime "next_due"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "currency"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",   :null => false
    t.string   "encrypted_password",     :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "name"
    t.boolean  "reset_token",            :default => true
    t.string   "stripe_id"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
