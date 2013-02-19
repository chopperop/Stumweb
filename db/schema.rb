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

ActiveRecord::Schema.define(:version => 20130211165429) do

  create_table "captions", :force => true do |t|
    t.text     "body"
    t.integer  "photo_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "cached_votes_total", :default => 0
    t.integer  "cached_votes_up",    :default => 0
    t.integer  "cached_votes_down",  :default => 0
  end

  add_index "comments", ["cached_votes_down"], :name => "index_comments_on_cached_votes_down"
  add_index "comments", ["cached_votes_total"], :name => "index_comments_on_cached_votes_total"
  add_index "comments", ["cached_votes_up"], :name => "index_comments_on_cached_votes_up"
  add_index "comments", ["commentable_id", "commentable_type"], :name => "Comments index"
  add_index "comments", ["user_id"], :name => "User_id Comments index"

  create_table "contents", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "content_changed_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "cached_votes_total", :default => 0
    t.integer  "cached_votes_up",    :default => 0
    t.integer  "cached_votes_down",  :default => 0
    t.integer  "impressions_count",  :default => 0
  end

  add_index "contents", ["cached_votes_down"], :name => "index_contents_on_cached_votes_down"
  add_index "contents", ["cached_votes_total"], :name => "index_contents_on_cached_votes_total"
  add_index "contents", ["cached_votes_up"], :name => "index_contents_on_cached_votes_up"
  add_index "contents", ["impressions_count"], :name => "contents_impressions_count"

  create_table "impressions", :force => true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], :name => "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], :name => "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], :name => "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], :name => "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], :name => "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], :name => "poly_session_index"
  add_index "impressions", ["user_id"], :name => "index_impressions_on_user_id"

  create_table "photos", :force => true do |t|
    t.integer  "user_id"
    t.string   "image"
    t.datetime "content_changed_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "cached_votes_total", :default => 0
    t.integer  "cached_votes_up",    :default => 0
    t.integer  "cached_votes_down",  :default => 0
    t.integer  "impressions_count",  :default => 0
  end

  add_index "photos", ["cached_votes_down"], :name => "index_photos_on_cached_votes_down"
  add_index "photos", ["cached_votes_total"], :name => "index_photos_on_cached_votes_total"
  add_index "photos", ["cached_votes_up"], :name => "index_photos_on_cached_votes_up"
  add_index "photos", ["impressions_count"], :name => "photos_impressions_count"

  create_table "team_relationships", :force => true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "team_name"
    t.string   "username"
    t.integer  "team_score", :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "email"
    t.string   "user1"
    t.integer  "user_id1"
    t.string   "user2"
    t.integer  "user_id2"
    t.string   "user3"
    t.integer  "user_id3"
  end

  create_table "teams_users", :id => false, :force => true do |t|
    t.integer "team_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
    t.integer  "score",                  :default => 0
    t.integer  "team_id"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "votes", :force => true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "vote_scope"
  end

  add_index "votes", ["votable_id", "votable_type"], :name => "index_votes_on_votable_id_and_votable_type"
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
