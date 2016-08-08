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

class Template < ApplicationRecord
  has_many :components
  has_many :templates, class_name: 'Component', foreign_key: 'component_id'

  has_attached_file :image, 
    styles: { medium: "300x300>", thumb: "100x100>" },
    url: "/templates/:style/:basename.:extension",
    path: ":rails_root/public/templates/:style/:basename.:extension",
    default_url: "/templates/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
