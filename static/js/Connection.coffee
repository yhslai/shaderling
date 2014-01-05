class Connection
  # @inPort.kind is 'out', @outPort.kind is 'out'
  constructor: (@inPort, @outPort) ->
    self = @
    $.observable(self)

    self.on('portMove', @relocate)

    xml = $.render($("#_connection").html())
    @svg = Snap.parse(xml).select('.connection')
    mainSvg = Snap('#main')
    mainSvg.prepend(@svg)
    @relocate()

  @makeConnection: (port1, port2) ->
    if port1.block is port2.block
      null
    else if port1.kind is 'in' and port2.kind is 'out'
      new @(port2, port1)
    else if port1.kind is 'out' and port2.kind is 'in'
      new @(port1, port2)
    else
      null

  relocate: () ->
    inBBox = @inPort.getBoundingBox()
    outBBox = @outPort.getBoundingBox()
    @svg.attr(
      x1: inBBox.x + inBBox.width / 2
      y1: inBBox.y + inBBox.height
      x2: outBBox.x + outBBox.width / 2
      y2: outBBox.y
    )

  otherPort: (thisPort) ->
    if thisPort.kind is 'in' then @inPort else @outPort



window.Connection = Connection