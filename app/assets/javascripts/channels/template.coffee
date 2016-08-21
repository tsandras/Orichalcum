App.template = App.cable.subscriptions.create "TemplateChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $('#template_feedback').append 'Template ' + data.template.template.id + ' save !'

  speak: (template) ->
    @perform 'speak', template: template

readURL = (input) ->
  if input.files and input.files[0]
    reader = new FileReader
    reader.onload = (e) ->
      $('#image_preview').append '<img src="' + e.target.result + '"/>'
      $('#template_image_data').val e.target.result
      $('#template_image_file_name').val $('#template_image').val().split('\\')[2]
      return
    reader.readAsDataURL input.files[0]
  return

jQuery ->
  $('#template-submit').on "click", ->
    inputs = $('input[name*=\'template\']')
    $('#template-form').ajaxForm
      success: (data) ->
        inputs.each (index) ->
          inputs.eq(index).val ''
          return
        $('#image_preview').html ''
        # $('#template_feedback').html ''
        App.template.speak data['template']
        return
      error: (xhr, status, str) ->
        console.log 'error'
        return
    return

  $('#template_image').on 'change', ->
    readURL this
    return
