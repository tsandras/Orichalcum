# == Schema Information
#
# Table name: template_traits
#
#  id          :integer          not null, primary key
#  template_id :integer          not null
#  trait_id    :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class TemplateTraitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
