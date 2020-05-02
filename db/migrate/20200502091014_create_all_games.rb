class CreateAllGames < ActiveRecord::Migration[5.1]
  def change
    create_table "all_games", primary_key: "id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
      t.integer "season_id", null: false
      t.integer "team_id_home", null: false
      t.integer "team_id_away", null: false
      t.date "game_date", null: false
      t.string "stadium_name", limit: 30, null: false
      t.integer "delete_flg", null: false
      t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
      t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    end 
  end
end
