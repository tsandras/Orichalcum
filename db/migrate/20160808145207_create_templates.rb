# Create templates table
class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.integer :rarity, null: false, default: 0
      t.string :name, null: false
      t.text :description
      t.attachment :image

      t.timestamps
    end
  end
end
