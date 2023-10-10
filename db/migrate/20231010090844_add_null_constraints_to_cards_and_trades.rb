class AddNullConstraintsToCardsAndTrades < ActiveRecord::Migration[7.0]
  def change
    change_column_null :cards, :name, false
    change_column_null :cards, :set, false
    change_column_null :cards, :rarity, false
    change_column_null :cards, :type, false
  end
end
