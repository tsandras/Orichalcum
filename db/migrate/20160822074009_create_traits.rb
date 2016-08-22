# create Trait table
class CreateTraits < ActiveRecord::Migration[5.0]
  def change
    create_table :traits do |t|
      t.string :kind, null: false
      t.string :name, null: false
      t.string :value, null: false
      t.text :description

      t.timestamps
    end
  end
end
