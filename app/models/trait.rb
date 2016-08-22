# == Schema Information
#
# Table name: traits
#
#  id          :integer          not null, primary key
#  kind        :string           not null
#  name        :string           not null
#  value       :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# app/models/trait.rb
class Trait < ApplicationRecord
  # Relations
  has_and_belongs_to_many :templates

  # Validations
  validates_presence_of :kind, :name, :value
end
