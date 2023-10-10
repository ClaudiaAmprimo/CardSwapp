class AddIndexesToCardsAndUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :cards, :name
    add_index :users, :username
  end
end
