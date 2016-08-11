# == Schema Information
#
# Table name: components
#
#  id           :integer          not null, primary key
#  template_id  :integer
#  component_id :integer
#  quantity     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

# app/models/component.rb
class Component < ApplicationRecord
  belongs_to :template
  belongs_to :component, class_name: 'Template', foreign_key: 'component_id'
end
