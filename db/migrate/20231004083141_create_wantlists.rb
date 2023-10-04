class CreateWantlists < ActiveRecord::Migration[7.0]
  def change
    create_table :wantlists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
