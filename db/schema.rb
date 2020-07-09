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

ActiveRecord::Schema.define(version: 2020_07_07_223955) do

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "dob"
    t.integer "jersey_number"
    t.string "jersey_size"
    t.integer "team_id"
  end

  create_table "records", force: :cascade do |t|
    t.integer "team_id"
    t.integer "win_total"
    t.integer "loss_total"
    t.integer "plus_mins_total"
  end

  create_table "season_teams", force: :cascade do |t|
    t.integer "season_id"
    t.integer "team_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.integer "year"
    t.string "which_season"
    t.integer "league_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "team_name"
    t.boolean "fee_paid?", default: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "user_id"
    t.string "password"
  end

end
