class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.integer :rarity
      t.string :name
      t.text :description
      t.attachment :image

      t.timestamps
    end
  end
end
