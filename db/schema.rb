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

ActiveRecord::Schema.define(version: 20200502091048) do

  create_table "all_games", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer "season_id", null: false
    t.integer "team_id_home", null: false
    t.integer "team_id_away", null: false
    t.date "game_date", null: false
    t.string "stadium_name", limit: 30, null: false
    t.integer "delete_flg", null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "all_teams", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "team_name", limit: 30, null: false
    t.string "team_logo_url", limit: 200
    t.integer "delete_flg", null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "game_details", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer "all_game_id", null: false
    t.integer "winner_id", null: false
    t.integer "score_home", null: false
    t.integer "score_away", null: false
    t.integer "delete_flg", null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["all_game_id"], name: "fk_rails_2585f30363"
  end

  create_table "seasons", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "season_name", limit: 30, null: false
    t.integer "delete_flg", null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "login_id", limit: 200, null: false
    t.string "password", limit: 1000, null: false
    t.string "name", limit: 30, null: false
    t.string "email", limit: 265, null: false
    t.integer "sex"
    t.date "birthday"
    t.integer "favorite1", null: false
    t.integer "favorite2"
    t.integer "favorite3"
    t.integer "delete_flg", null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "users_logs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer "user_id", null: false
    t.integer "all_game_id", null: false
    t.string "comment", limit: 2000
    t.string "image_url", limit: 200
    t.integer "delete_flg", null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["all_game_id"], name: "fk_rails_de2024fceb"
    t.index ["user_id"], name: "fk_rails_461215c26c"
  end

  add_foreign_key "game_details", "all_games"
  add_foreign_key "users_logs", "all_games"
  add_foreign_key "users_logs", "users"
end
