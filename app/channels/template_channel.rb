# app/channels/template_channel.rb
class TemplateChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'template_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    options = Template.all.map { |t| "<option value=#{t.id}>#{t.name}</option>" }
    options = options.join(';')
    ActionCable.server.broadcast 'template_channel', template: data, options: options
  end
end
