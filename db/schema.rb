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

ActiveRecord::Schema.define(:version => 20110311192704) do

  create_table "category_relations", :force => true do |t|
    t.string   "our_tag"
    t.string   "fsq_tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "foursquare_access_token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "photo"
    t.integer  "treats",                  :default => 0
  end

  create_table "question_responses", :force => true do |t|
    t.string   "text"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "text"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tag"
  end

  create_table "round_scores", :force => true do |t|
    t.integer  "player_id"
    t.integer  "session_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "score_histories", :force => true do |t|
    t.integer  "player_id"
    t.integer  "venue_id"
    t.integer  "score",      :default => 0
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "session_players", :force => true do |t|
    t.integer  "player_id"
    t.integer  "session_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "session_questions", :force => true do |t|
    t.integer  "session_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "venue_id"
  end

  create_table "venue_question_relations", :force => true do |t|
    t.integer  "venue_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "foursquare_id"
    t.integer  "session_id"
  end

end
