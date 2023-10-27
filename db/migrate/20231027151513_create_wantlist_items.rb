class CreateWantlistItems < ActiveRecord::Migration[7.0]
  def change
    create_table :wantlist_items do |t|
      t.references :wantlist, foreign_key: true
      t.references :card, foreign_key: true
      t.timestamps
    end
  end
end
