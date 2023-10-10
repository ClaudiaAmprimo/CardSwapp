class AddStatusToTrades < ActiveRecord::Migration[7.0]
  def change
    add_column :trades, :status, :string, null: false, default: 'initiated'
    add_index :trades, :status
  end
end
