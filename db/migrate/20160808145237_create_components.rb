class CreateComponents < ActiveRecord::Migration[5.0]
  def change
    create_table :components do |t|
      t.integer :template_id
      t.integer :component_id

      t.timestamps
    end
  end
end
