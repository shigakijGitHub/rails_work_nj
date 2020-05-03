class RemoveWinnerIdFromGameDetails < ActiveRecord::Migration[5.1]
  def change
    remove_column :game_details, :winner_id, :int
  end
end
