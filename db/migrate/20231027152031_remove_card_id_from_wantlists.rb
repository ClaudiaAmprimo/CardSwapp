class RemoveCardIdFromWantlists < ActiveRecord::Migration[7.0]
  def change
    remove_column :wantlists, :card_id, :bigint
  end
end
