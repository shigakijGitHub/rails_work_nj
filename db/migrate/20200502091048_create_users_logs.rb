class CreateUsersLogs < ActiveRecord::Migration[5.1]
  def change
    create_table "users_logs", primary_key: "id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
      t.integer "user_id", null: false
      t.integer "all_game_id", null: false
      t.string "comment", limit: 2000
      t.string "image_url", limit: 200
      t.integer "delete_flg", null: false
      t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
      t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    end
    add_foreign_key :users_logs, :all_games
    add_foreign_key :users_logs, :users
  end
end
