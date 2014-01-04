#= require Connection

class Port
  constructor: (@block, @type, @kind) ->
    self = @
    $.observable(self)

    @selected = false
    @connections = []

    portXml = $.render($("#_port").html(), { kind: @kind })
    @svg = Snap.parse(portXml).select('.port')

    @svg.click(-> self.onClick())

  onClick: ->
    if @selected
      @unselect()
    else
      other = Shaderling.selectedPort
      if other
        connection = Connection.makeConnection(@, other)
        @connections.push(connection)
        @unselect()
        other.unselect()
      else
        Shaderling.selectedPort = @
        @svg.node.classList.add('selected')
        @selected = true

  unselect: ->
    Shaderling.selectedPort = null if Shaderling.selectedPort is @
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

  centerPos: () ->
    x = @block.realPos.x
    y = @block.realPos.y
    ox = parseInt(@svg.attr('x'))
    oy = parseInt(@svg.attr('y'))
    w = parseInt(@svg.attr('width'))
    h = parseInt(@svg.attr('height'))
    {
      x: x + ox + w / 2
      y: y + oy + h / 2
    }


window.Port = Port