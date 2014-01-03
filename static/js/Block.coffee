class Block
  constructor: () ->
    self = @
    $block = $($.render($('#_block').html()))
    @svg = Snap.parse($block.html()).select('.block-svg')
    @dom = $block.find('.block-dom')

    oldPos = {}
    @svg.drag(((dx, dy, posx, posy) -> 
      self.move(oldPos.x + dx, oldPos.y + dy)
    ), ((posx, posy) ->
      oldPos = {
        x: parseInt(@attr("x"))
        y: parseInt(@attr("y"))
      }
    ), ( ->
    ))

  appendTo: (svg, dom) ->
    svg.append(@svg)
    dom.append(@dom)
    @relocateDom()

  move: (x, y) ->
    @svg.attr(
      x: x
      y: y
    )
    @relocateDom()

  relocateDom: () ->
    $svg = $(@svg.node)
    offset = $svg.offset()
    @dom.offset(
      left: offset.left + $svg.width() / 2
      top: offset.top
    )
    @dom.css(
      width: @svg.attr('width')
      height: $svg.attr('height')
    )


window.Block = Block

  

