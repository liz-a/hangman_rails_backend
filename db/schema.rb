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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "games", force: :cascade do |t|
    t.string "game_name"
    t.string "word"
    t.integer "lives"
    t.integer "status"
    t.integer "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "slack_name"
    t.string "slack_id"
    t.integer "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "active_game_on_game_id"
    t.index ["game_id"], name: "player_games_on_game_id"
  end

  create_table "guesses", force: :cascade do |t|
    t.string "slack_name"
    t.string "slack_id"
    t.integer "game_id"
    t.string "guess"
    t.boolean "correct_or_incorrect"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "guesses_on_game_id"
  end

end
