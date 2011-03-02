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

ActiveRecord::Schema.define(:version => 20110302010504) do

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

  create_table "experiences", :force => true do |t|
    t.string   "title"
    t.integer  "user_id_creator"
    t.string   "visibility"
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

  create_table "moments", :force => true do |t|
    t.integer  "user_id_creator"
    t.integer  "thing_id"
    t.integer  "location_id"
    t.integer  "caption_id"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "experience_id"
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
  end

  create_table "things", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",   :limit => 25
    t.string   "password",   :limit => 100
    t.string   "role",       :limit => 20,  :default => "user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
