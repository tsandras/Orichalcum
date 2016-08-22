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

require 'test_helper'

class TraitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
