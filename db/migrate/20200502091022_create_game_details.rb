class CreateGameDetails < ActiveRecord::Migration[5.1]
  def change
      create_table "game_details", primary_key: "id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
        t.integer "all_game_id", null: false
        t.integer "winner_id", null: false
        t.integer "score_home", null: false
        t.integer "score_away", null: false
        t.integer "delete_flg", null: false
        t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
        t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    end
    add_foreign_key :game_details, :all_games
  end
end
