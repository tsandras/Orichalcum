# == Schema Information
#
# Table name: templates
#
#  id                 :integer          not null, primary key
#  rarity             :integer
#  name               :string
#  description        :text
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

# app/models/template.rb
class Template < ApplicationRecord
  has_many :component_joins, class_name: 'Component', foreign_key: 'template_id'
  has_many :components,
           through: :component_joins,
           foreign_key: 'component_id',
           source: 'component'
  has_many :template_joins, class_name: 'Component', foreign_key: 'component_id'
  has_many :templates,
           through: :template_joins,
           foreign_key: 'template_id',
           source: 'template'

  has_attached_file :image,
                    styles: { medium: '300x300>', thumb: '50x50>' },
                    url: '/templates/:style/:basename.:extension',
                    path: ':rails_root/public/templates/:style/:basename.:extension',
                    default_url: '/templates/:style/missing.png'

  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\Z}

  def self.tree(template, deep = 2)
    noeud = { template: template.name, components: [] }
    return noeud if deep <= 0
    template.components.each do |component|
      noeud[:components].push(tree(component, deep - 1))
    end
    noeud
  end
end
