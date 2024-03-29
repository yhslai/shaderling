#= require Connection

class Port
  constructor: (@block, @type, @kind) ->
    self = @
    $.observable(self)

    self.on('newConnection', @onNewConnection)

    @selected = false
    @connections = []

    portXml = $.render($("#_port").html(), { kind: @kind })
    @svg = Snap.parse(portXml).select('.port')
    @svg.attr('visibility', 'hidden') if @type.hidden?

    @svg.click(-> self.onClick())

  onClick: ->
    if @selected
      @unselect()
    else
      other = Shaderling.selected
      if other instanceof Port
        oldOther = @connectedPort()
        connection = Connection.makeConnection(@, other)
        @trigger('newConnection', connection)
        other.trigger('newConnection', connection)
        @unselect()
        other.unselect()
      else
        other?.unselect()
        Shaderling.selected = @
        @svg.node.classList.add('selected')
        @selected = true

  onNewConnection: (connection) ->
    self = @

    oldOther = @connectedPort()
    @connections.push(connection)

    setTimeout((-> self.portChange()), 0) # wait until connections/ports are all updated

  onConnectionRemove: (connection) ->
    self = @
    
    index = @connections.indexOf(connection)
    if index isnt -1
      @connections.splice(index, 1)
      setTimeout((-> self.portChange()), 0) # wait until connections/ports are all updated

  portChange: () ->
    @block.trigger('portChange', @, @connectedPort())
    Shaderling.refresh()

  unselect: ->
    Shaderling.selected = null if Shaderling.selected is @
    @svg.node.classList.remove('selected')
    @selected = false

  locate: (index, total, blockWidht, blockHeight) ->
    portWidth = parseInt(@svg.attr('width'))
    portHeight = parseInt(@svg.attr('height'))
    y = if @kind is 'in' then 0 else blockHeight - portHeight - 0.5
    x = if index is 0 then 0 else (blockWidht - portWidth) / (total - 1) * index

    @svg.attr(
      x: x
      y: y
    )

    @connections.forEach((c) -> c.trigger('portMove', @))

  getBoundingBox: () ->
    x = @block.realPos.x
    y = @block.realPos.y
    ox = parseInt(@svg.attr('x'))
    oy = parseInt(@svg.attr('y'))
    w = parseInt(@svg.attr('width'))
    h = parseInt(@svg.attr('height'))
    {
      x: x + ox
      y: y + oy
      width: w
      height: h
    }

  isUsed: () ->
    @connectedPort()?

  connectedPort: () ->
    @connections[0]?.otherPort(@)

  updateName: () ->
    self = @
    generateName = () ->
      type = self.type
      "#{type.type}_#{type.modifier}_#{type.annotation}_#{Shaderling.Utils.generateUUID(6)}"

    if @kind is 'in'
      @name = @connectedPort()?.name ? generateName()
    else
      @name = generateName()



window.Port = Port