class Port
  constructor: (@block, @type, @kind) ->
    self = @
    $.observable(self)

    portXml = $.render($("#_port").html(), { kind: @kind })
    @svg = Snap.parse(portXml).select('.port')

  locate: (index, total, blockWidht, blockHeight) ->
    portWidth = parseInt(@svg.attr('width'))
    portHeight = parseInt(@svg.attr('height'))
    y = if @kind is 'in' then 0 else blockHeight - portHeight - 1
    x = if index is 0 then 0 else (blockWidht - portWidth) / (total - 1) * index

    @svg.attr(
      x: x
      y: y
    )

window.Port = Port