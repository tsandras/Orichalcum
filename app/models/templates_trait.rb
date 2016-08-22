# == Schema Information
#
# Table name: templates_traits
#
#  id          :integer          not null, primary key
#  template_id :integer          not null
#  trait_id    :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# app/models/template_traits
class TemplatesTrait < ApplicationRecord
  # Relations
  belongs_to :template
  belongs_to :trait

  # Validations
  validates_presence_of :template_id, :trait_id
end
