PHASER_ASSETS = {}

PHASER_ASSETS.preload = ->
  game = PHASER_ASSETS.game
  game.load.image 'default', '/templates/empty_location.png'
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
  newSprite.events.onDragStop.add onDragStop, { template: template }, this
  treeConnector.templatesTree.setSprite template, newSprite
  return

over = (item) ->
  item.input.useHandCursor = true
  @template.text.visible = true
  return

listener = (item) ->
  @template.text.visible = false
  return

onDragStop = (sprite, pointer) ->
  treeConnector = PHASER_ASSETS.treeConnector
  t = treeConnector.templatesTree.getTemplate(sprite.key)
  if !t
    t = treeConnector.templatesTree.disconnected[sprite.key]
  if treeConnector.templatesTree.isNearTo(pointer.x, pointer.y)
    treeConnector.templatesTree.changeNode t, pointer.x, pointer.y
  else
    treeConnector.templatesTree.removeNode t, pointer.x, pointer.y
  return

window.PHASER_ASSETS = PHASER_ASSETS
