# == Schema Information
#
# Table name: templates
#
#  id                 :integer          not null, primary key
#  rarity             :integer          default(0), not null
#  name               :string           not null
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
  # Attributes
  attr_accessor :image_url, :image_thumb_url, :image_data

  # Relations
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
  has_and_belongs_to_many :traits
  has_attached_file :image,
                    styles: { medium: '300x300>', thumb: '50x50>' },
                    url: '/templates/:style/:basename.:extension',
                    path: ':rails_root/public/templates/:style/:basename.:extension',
                    default_url: '/templates/:style/missing.png'

  # Check the integrity of instance
  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\Z}
  validates_presence_of :name, :rarity

  # Scopes
  scope :rarities, -> (rarity) { where(rarity: rarity) }

  # Callbacks
  before_save :decode_base64_image

  # Public methods
  def image_url
    @image_url = image.url
  end

  def image_thumb_url
    @image_thumb_url = image.url(:thumb)
  end

  def attributes
    super.merge(image_url: image_url, image_thumb_url: image_thumb_url)
  end

  def self.random_tree
    tree(random)
  end

  def self.random
    Template.offset(rand(Template.count)).first
  end

  def self.tree(template, deep = 2)
    noeud = { template: template, components: [] }
    return noeud if deep <= 0
    template.components.each do |component|
      noeud[:components].push(tree(component, deep - 1))
    end
    noeud
  end

  def self.save_components(relations)
    relations.each do |template_id, component_ids|
      template = Template.find_by_id(template_id)
      template.components.destroy_all if template.present?
      component_ids.each do |component_id|
        Component.create(template_id: template_id, component_id: component_id)
      end
    end
  end

  protected

  def decode_base64_image
    if image_data.present?
      blob = image_data.split(',')[1]
      data = StringIO.new(Base64.decode64(blob))
      data.class_eval do
        attr_accessor :content_type, :original_filename
      end
      data.original_filename = image_file_name
      self.image = data
    end
  end
end
