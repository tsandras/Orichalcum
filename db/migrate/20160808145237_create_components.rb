# Create components table
class CreateComponents < ActiveRecord::Migration[5.0]
  def change
    create_table :components do |t|
      t.integer :template_id, null: false
      t.integer :component_id, null: false
      t.integer :quantity, null: false, default: 1
      t.timestamps
    end
    add_index :components, [:template_id, :component_id], unique: true
  end
end
