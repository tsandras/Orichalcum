TemplatesTree = (game, tree, xroot, yroot) ->
  self = this
  self.game = game
  self.xroot = xroot
  self.yroot = yroot
  self.allGraphics = []
  self.disconnected = {}

  getPositionOfFirst = (nbsComponents, x) ->
    half = Math.round(nbsComponents / 2)
    x - ((half + 1) * 100)

  self.setTree = (tree) ->
    self.tree = constructTree(tree, self.xroot, self.yroot)
    return

  self.removeTree = ->
    if self.tree
      self.allGraphics.forEach (graphic) ->
        graphic.clear()
        return
      self.allGraphics = []
      subRemoveTree self.tree
      self.tree = null
    return

  subRemoveTree = (tree) ->
    if tree.template.sprite
      tree.template.sprite.kill()
      tree.template.sprite = null
    tree.template.text.destroy()
    tree.components.forEach (component) ->
      subRemoveTree component, name
      return
    return

  constructTree = (tree, x, y) ->
    noeud = 
      template: new Template(self.game, tree.template, x, y)
      components: []
    nbsComponents = tree.components.length
    xtemp = getPositionOfFirst(nbsComponents, x)
    i = 1
    tree.components.forEach (component) ->
      if nbsComponents % 2 == 0 and i == 2
        xtemp = xtemp + 200
      else
        xtemp = xtemp + 100
      i++
      noeud.components.push constructTree(component, xtemp, y + 100)
      return
    noeud

  if tree
    self.tree = constructTree(tree, self.xroot, self.yroot)
  else
    self.tree = null

  connectTwoTemplates = (t1, t2) ->
    graphics = self.game.add.graphics(0, 0)
    graphics.beginFill 0xFF3300
    graphics.lineStyle 3, 0xA9A9A9, 1
    graphics.moveTo t1.getCenter().x, t1.getCenter().y
    graphics.lineTo t2.getCenter().x, t2.getCenter().y
    graphics.endFill()
    self.allGraphics.push graphics
    return

  subDrawConnection = (tree) ->
    tree.components.forEach (component) ->
      subDrawConnection component
      connectTwoTemplates tree.template, component.template
      return
    return

  self.drawConnection = ->
    subDrawConnection self.tree
    return

  subGetTemplate = (tree, name) ->
    if tree.template.name == name
      window.out = tree.template
      return
    tree.components.forEach (component) ->
      subGetTemplate component, name
      return
    return

  self.getTemplate = (name) ->
    # TODO improve getTemplate...
    window.out = null
    subGetTemplate self.tree, name
    return window.out

  subLoad = (tree) ->
    tree.template.load()
    tree.components.forEach (component) ->
      subLoad component
      return
    return

  self.load = ->
    subLoad self.tree
    return

  self.removeNode = (node, x, y) ->
    subRemoveNode @tree, node, x, y
    return

  subRemoveNode = (tree, node, x, y) ->
    if tree.template == node
      tree.template = new Template(self.game, null, node.x, node.y)
      tree.template.name = node.x + ';' + node.y
      defaultt = game.add.sprite(node.x, node.y, 'default')
      tree.template.sprite = defaultt
      node.text.x = x + 55
      node.text.y = y + 10
      self.disconnected[node.name] = node
    tree.components.forEach (component) ->
      subRemoveNode component, node, x, y
      return
    return

  self.changeNode = (node, x, y) ->
    subChangeNode @tree, node, x, y
    return

  subChangeNode = (tree, node, x, y) ->
    if x < tree.template.x + 50 and x > tree.template.x - 50 and y < tree.template.y + 50 and y > tree.template.y - 50 and node.name != tree.template.name
      self.disconnected[tree.template.name] = tree.template
      tree.template.sprite.kill()
      tmpX = tree.template.x
      tmpY = tree.template.y
      tree.template = node
      tree.template.x = tmpX
      tree.template.y = tmpY
      tree.template.sprite.x = tmpX
      tree.template.sprite.y = tmpY
      tree.template.text.x = tmpX + 55
      tree.template.text.y = tmpY + 10
    tree.components.forEach (component) ->
      subChangeNode component, node, x, y
      return
    return

  self.isNearTo = (x, y) ->
    # TODO improve isNearTo...
    window.out = false
    subIsNearTo @tree, x, y
    window.out

  subIsNearTo = (tree, x, y) ->
    if x < tree.template.x + 50 and x > tree.template.x - 50 and y < tree.template.y + 50 and y > tree.template.y - 50
      window.out = true
      return
    tree.components.forEach (component) ->
      subIsNearTo component, x, y
      return
    return

  self.show = () ->
    subShow self.tree
    return

  subShow = (tree) ->
    tree.components.forEach (component) ->
      subShow component
      return
    return

  self.hashOfComponents = () ->
    window.out = {}
    subShortTree self.tree.template, self.tree
    window.out

  subShortTree = (older, tree) ->
    if older == tree.template
      window.out[older.id] = []
    else
      if window.out[older.id]
        window.out[older.id].push(tree.template.id)
      else
        window.out[older.id] = [tree.template.id]
    tree.components.forEach (component) ->
      subShortTree tree.template, component
      return
    return

  self.setSprite = (template, sprite) ->
    subSetPrite(self.tree, template, sprite)
    return

  subSetPrite = (tree, template, sprite) ->
    if tree.template.id == template.id
      tree.template.sprite = sprite
    tree.components.forEach (component) ->
      subSetPrite component, template, sprite
      return
    return

  return

window.TemplatesTree = TemplatesTree
