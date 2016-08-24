TreeConnector = (game, templatesTree) ->
  self = this
  self.templatesTree = templatesTree
  self.game = game
  requestForTemplatesTree = (route, templateId) ->
    data = null
    if templateId
      data = id: templateId
    $.ajax
      type: 'POST'
      url: '/items_creator/' + route
      data: data
      success: (response, textStatus) ->
        self.templatesTree.removeTree()
        self.templatesTree.setTree response
        self.templatesTree.load()
        self.templatesTree.drawConnection()
        self.game.load.start()
        return
    return

  requestForTemplate = (route) ->
    $.ajax
      type: 'POST'
      url: '/items_creator/' + route
      success: (response, textStatus) ->
        console.log response
        template = new Template(self.templatesTree.game, response, 500, 100)
        self.templatesTree.disconnected[template.name] = template
        template.load()
        self.game.load.start()
        return
    return

  requestForSaveTree = (shortTree) ->
    $.ajax
      type: 'POST'
      url: '/items_creator/save_tree'
      data: { components: shortTree }
      success: (response, textStatus) ->
        console.log response
        return
    return

  self.listenerSelect = ->
    $('#template_id').change ->
      template = $('#template_id option:selected')
      requestForTemplatesTree 'templates_tree', template.val()
      return
    return

  self.listenerRandom = ->
    $('#random_templates_tree').on 'click', ->
      requestForTemplatesTree 'random_templates_tree', null
      return
    return

  self.listenerRandomTemplate = ->
    $('#random_template').on 'click', ->
      console.log 'on click'
      requestForTemplate 'random_template'
      return
    return

  self.listenerSaveTree = ->
    $('#save_tree').on 'click', ->
      requestForSaveTree self.templatesTree.hashOfComponents()
      return
    return

  return

window.TreeConnector = TreeConnector
