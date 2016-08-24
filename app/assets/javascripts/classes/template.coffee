Template = (game, templateData, x, y) ->
  @x = x
  @y = y
  @game = game
  if templateData
    @id = templateData.id
    @name = templateData.name
    @data = templateData
    @text = game.add.text(@x + 55, @y + 10, '',
      font: '12px'
      fill: '#000'
      align: 'left'
      boundsAlignH: 'left'
      boundsAlignV: 'top'
      wordWrap: true
      wordWrapWidth: 300)
    @text.setTextBounds 0, 0, 80, 30
    @text.visible = false
    @text.text = @name + ': ' + templateData.description
  @sprite = null

  @getCenter = ->
    {
      x: @x + 25
      y: @y + 25
    }

  @load = ->
    @game.load.image @name, @data.image_thumb_url
    return

  return

window.Template = Template
