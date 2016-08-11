# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# app/models/message.rb
class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later self }
end
