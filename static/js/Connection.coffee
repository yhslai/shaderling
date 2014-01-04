class Connection
  constructor: (@inPort, @outPort) ->
    self = @
    $.observable(self)

    inPos = @inPort.centerPos()
    outPos = @outPort.centerPos()
    xml = $.render($("#_connection").html(),
      x1: inPos.x
      y1: inPos.y
      x2: outPos.x
      y2: outPos.y
    )
    @svg = Snap.parse(xml).select('.connection')
    mainSvg = Snap('#main')
    mainSvg.prepend(@svg)

  @makeConnection: (port1, port2) ->
    if port1.block is port2.block
      null
    else if port1.kind is 'in' and port2.kind is 'out'
      new @(port1, port2)
    else if port1.kind is 'out' and port2.kind is 'in'
      new @(port2, port1)
    else
      null


window.Connection = Connection