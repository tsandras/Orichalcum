# Remplace tree by TemplatesTree !! 
Template = (game, templatesTree, templateData, x, y) ->
  @x = x
  @y = y
  @game = game
  @text = null
  if templateData
    @id = templateData.id
    @name = templateData.name
    @data = templateData
    @text = game.add.text(@x + 55, @y + 5, '',
      font: '10px'
      fill: '#000'
      align: 'left'
      boundsAlignH: 'left'
      boundsAlignV: 'top'
      wordWrap: true
      wordWrapWidth: 300)
    @text.setTextBounds 0, 0, 100, 40
    @text.visible = false
    @text.text = @name + ': ' + templateData.description
  @sprite = null
  @shape = null
  graphics = game.add.graphics(@x, @y);
  graphics.lineStyle 1, 0x000000, 1
  graphics.drawRect(0, 0, 150, 50);
  @shape = graphics
  @shape.visible = false
  @plus = @game.add.sprite(@x + 25, @y + 50, 'plus')
  @plus.visible = false
  @plus.inputEnabled = true

  over = ->
    this.plus.input.useHandCursor = true

  listener = ->
    # console.log(this.templatesTree);
    this.templatesTree.addEmptyTemplate(this.template)
    return


  @plus.events.onInputOver.add over, this
  @plus.events.onInputDown.add listener, {templatesTree: templatesTree, template: this}, this

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
