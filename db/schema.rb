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

ActiveRecord::Schema.define(:version => 20110510202443) do

  create_table "assets", :force => true do |t|
    t.integer  "user_id",                         :null => false
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
    t.string   "tmp_url"
    t.string   "panda_id"
  end

  create_table "causes", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.integer  "action_id",                  :null => false
    t.string   "action_type",  :limit => 50, :null => false
    t.integer  "subject_id",                 :null => false
    t.string   "subject_type", :limit => 50, :null => false
    t.string   "type",         :limit => 50, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "causes", ["action_type", "action_id"], :name => "index_causes_on_action_type_and_action_id"
  add_index "causes", ["subject_type", "subject_id"], :name => "index_causes_on_subject_type_and_subject_id"
  add_index "causes", ["user_id"], :name => "index_causes_on_user_id"

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
    t.string   "hashtag",         :limit => 35, :null => false
    t.string   "prize"
    t.integer  "prize_at_moment"
  end

  create_table "experience_collaborators", :force => true do |t|
    t.integer "experience_id"
    t.integer "user_id"
  end

  add_index "experience_collaborators", ["experience_id", "user_id"], :name => "index_experience_collaborators_on_experience_id_and_user_id", :unique => true

  create_table "experiences", :force => true do |t|
    t.string   "title"
    t.integer  "user_id",                                            :null => false
    t.string   "visibility",      :limit => 7, :default => "public", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "views",                        :default => 0
    t.integer  "moments_count",                :default => 0
    t.integer  "likes_count",                  :default => 0
    t.integer  "comments_count",               :default => 0
    t.integer  "moment_id_cover"
  end

  create_table "geocodes", :force => true do |t|
    t.float    "lat",                       :null => false
    t.float    "lng",                       :null => false
    t.string   "street"
    t.string   "city",       :limit => 100
    t.string   "state",      :limit => 2
    t.string   "zip",        :limit => 10
    t.string   "country",    :limit => 100
    t.datetime "lookup_at"
    t.boolean  "success"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "geocodes", ["lat", "lng"], :name => "index_geocodes_on_lat_and_lng", :unique => true

  create_table "invites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.integer  "user_id_to"
    t.integer  "experience_id"
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

  create_table "moment_flags", :force => true do |t|
    t.integer  "user_id",                                  :null => false
    t.integer  "moment_id",                                :null => false
    t.string   "type",       :limit => 50,                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shot",                     :default => "", :null => false
  end

  add_index "moment_flags", ["moment_id"], :name => "index_moment_flags_on_moment_id"
  add_index "moment_flags", ["user_id"], :name => "index_moment_flags_on_user_id"

  create_table "moments", :force => true do |t|
    t.integer  "user_id",                       :null => false
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
    t.integer  "likes_count",    :default => 0
    t.integer  "comments_count", :default => 0
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "cause_id",                      :null => false
    t.boolean  "seen",       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["user_id", "seen"], :name => "index_notifications_on_user_id_and_seen"

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
    t.string   "gender",               :limit => 1,   :default => "", :null => false
    t.integer  "photo_asset_id"
    t.integer  "zodiac_western_id"
    t.string   "dont_notify_for",                     :default => "", :null => false
    t.string   "timezone",             :limit => 100
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
    t.integer  "failed_attempts",                     :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "disabled",                            :default => false,  :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "zodiacs", :force => true do |t|
    t.string  "name",   :limit => 30,  :default => "", :null => false
    t.string  "phrase", :limit => 75,  :default => "", :null => false
    t.string  "url",    :limit => 200, :default => "", :null => false
    t.string  "type",   :limit => 50,                  :null => false
    t.integer "lookup", :limit => 2
  end

  add_index "zodiacs", ["lookup"], :name => "index_zodiacs_on_lookup"

end
