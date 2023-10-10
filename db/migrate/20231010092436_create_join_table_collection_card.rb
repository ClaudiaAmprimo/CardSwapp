class CreateJoinTableCollectionCard < ActiveRecord::Migration[7.0]
  def change
    create_join_table :collections, :cards do |t|
      t.index [:collection_id, :card_id]
      t.index [:card_id, :collection_id]
    end
  end
end
