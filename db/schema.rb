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

ActiveRecord::Schema.define(:version => 20110322213613) do

  create_table "assets", :force => true do |t|
    t.integer  "user_id_creator"
    t.integer  "source_id"
    t.string   "type",              :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.float    "lat"
    t.float    "lng"
    t.datetime "taken_at"
    t.string   "device"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",       :limit => 30
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "moment_id"
  end

  create_table "connections", :force => true do |t|
    t.integer  "user_id_from"
    t.integer  "user_id_to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "name",       :limit => 100
    t.string   "email",      :limit => 200
    t.string   "facebook",   :limit => 50
    t.string   "twitter",    :limit => 50
    t.string   "phone",      :limit => 20
    t.string   "skype",      :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "event_locations", :force => true do |t|
    t.integer  "event_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "experience_id"
  end

  create_table "experiences", :force => true do |t|
    t.string   "title"
    t.integer  "user_id_creator"
    t.string   "visibility"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "views",           :default => 0
    t.integer  "moments_count",   :default => 0
    t.integer  "likes_count",     :default => 0
    t.integer  "comments_count",  :default => 0
  end

  create_table "likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "moment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city",         :limit => 100
    t.string   "state",        :limit => 2
    t.string   "zip",          :limit => 10
    t.string   "precision",    :limit => 30,  :default => "unknown"
    t.float    "lat"
    t.float    "lng"
    t.integer  "meter_radius"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "moment_contacts", :force => true do |t|
    t.integer  "moment_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "moments", :force => true do |t|
    t.integer  "user_id_creator"
    t.integer  "thing_id"
    t.integer  "location_id"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "experience_id"
    t.integer  "source_id"
    t.integer  "asset_id"
    t.integer  "caption_id"
    t.integer  "likes_count",     :default => 0
    t.integer  "comments_count",  :default => 0
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "realname",             :limit => 100
    t.datetime "birthday"
    t.integer  "location_id_hometown"
    t.integer  "location_id_current"
    t.string   "website"
    t.string   "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender",               :limit => 7,   :default => "unknown"
    t.integer  "photo_asset_id"
  end

  create_table "services", :force => true do |t|
    t.integer  "user_id"
    t.integer  "id_external"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",        :limit => 25
  end

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "things", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",             :limit => 50
    t.string   "role",                 :limit => 20,  :default => "user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                               :default => "",     :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",     :null => false
    t.string   "password_salt",                       :default => "",     :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "contact_id"
    t.integer  "profile_id"
    t.integer  "likes_count",                         :default => 0
    t.boolean  "force_reset"
    t.integer  "experiences_count",                   :default => 0,      :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
