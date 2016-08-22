# == Schema Information
#
# Table name: components
#
#  id           :integer          not null, primary key
#  template_id  :integer          not null
#  component_id :integer          not null
#  quantity     :integer          default(1), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

# app/models/component.rb
class Component < ApplicationRecord
  # Relations
  belongs_to :template
  belongs_to :component, class_name: 'Template', foreign_key: 'component_id'

  # Validations
  validates_presence_of :template_id, :component_id
end
