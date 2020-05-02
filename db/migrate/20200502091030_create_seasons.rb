class CreateSeasons < ActiveRecord::Migration[5.1]
  def change
      create_table "seasons", primary_key: "id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
        t.string "season_name", limit: 30, null: false
        t.integer "delete_flg", null: false
        t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
        t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    end
  end
end
