class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.references :sender, foreign_key: { to_table: :users }
      t.references :receiver, foreign_key: { to_table: :users }
      t.references :trade, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
