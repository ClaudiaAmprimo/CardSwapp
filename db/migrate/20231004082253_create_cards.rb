class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :set
      t.string :rarity
      t.string :type
      t.string :image_url

      t.timestamps
    end
  end
end
