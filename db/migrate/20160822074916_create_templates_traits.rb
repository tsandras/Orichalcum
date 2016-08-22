# create TemplatesTrait table
class CreateTemplatesTraits < ActiveRecord::Migration[5.0]
  def change
    create_table :templates_traits do |t|
      t.integer :template_id, null: false
      t.integer :trait_id, null: false

      t.timestamps
    end
  end
end
