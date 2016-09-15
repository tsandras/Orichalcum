PHASER_ASSETS = {}

PHASER_ASSETS.preload = ->
  game = PHASER_ASSETS.game
  game.load.image 'default', '/templates/empty_location.png'
  game.load.image 'plus', '/plus.png'
  game.load.image 'croix', '/croix.png'
  return

PHASER_ASSETS.create = ->
  game = PHASER_ASSETS.game
  game.stage.backgroundColor = '#FFFFFF'
  game.load.onFileComplete.add fileComplete, this
  return

fileComplete = (progress, cacheKey, success, totalLoaded, totalFiles) ->
  game = PHASER_ASSETS.game
  treeConnector = PHASER_ASSETS.treeConnector
  template = null
  if treeConnector.templatesTree.tree
    template = treeConnector.templatesTree.getTemplate(cacheKey)
  if !template
    template = treeConnector.templatesTree.disconnected[cacheKey]
  newSprite = game.add.sprite(template.x, template.y, cacheKey)
  newSprite.inputEnabled = true
  newSprite.input.enableDrag()
  newSprite.events.onInputOver.add over, {template: template}, this
  newSprite.events.onInputDown.add listener, {template: template}, this
  newSprite.events.onDragStop.add onDragStop, { template: template }, this
  treeConnector.templatesTree.setSprite template, newSprite
  return

over = (item) ->
  item.input.useHandCursor = true
  return

listener = (item) ->
  treeConnector = PHASER_ASSETS.treeConnector
  t = treeConnector.templatesTree.getTemplate(@template.name)
  if @template.text.visible
    @template.text.visible = false
    @template.shape.visible = false
    @template.plus.visible = false
  else
    @template.text.visible = true
    @template.shape.visible = true
    if t
      @template.plus.visible = true
  return

onDragStop = (sprite, pointer) ->
  treeConnector = PHASER_ASSETS.treeConnector
  t = treeConnector.templatesTree.getTemplate(sprite.key)
  disconnected = false
  if !t
    disconnected = true
    t = treeConnector.templatesTree.disconnected[sprite.key]
  nearTo = treeConnector.templatesTree.isNearTo(sprite.x, sprite.y)
  if disconnected && !nearTo
    t = treeConnector.templatesTree.disconnected[sprite.key]
    t.shape.position.x = sprite.x
    t.shape.position.y = sprite.y
    t.text.x = sprite.x + 55
    t.text.y = sprite.y + 10
    t.plus.x = sprite.x + 25
    t.plus.y = sprite.y + 50
  else if nearTo
    treeConnector.templatesTree.changeNode t, sprite.x, sprite.y
  else
    treeConnector.templatesTree.removeNode t, sprite.x, sprite.y
  return

window.PHASER_ASSETS = PHASER_ASSETS
