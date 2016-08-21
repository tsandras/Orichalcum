# app/channels/template_channel.rb
class TemplateChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'template_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast 'template_channel', template: data
  end
end
