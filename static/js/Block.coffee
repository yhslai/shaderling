class Block
  constructor: () ->
    self = @
    $.observable(self)

    self.on('appendTo', @onAppendTo)

    viewContext = () ->
      id: self.id
      data: self.data
      name: self.name
      comment: self.comment

    @inPorts ?= []
    @outPorts ?= []
    @id ?= 'block'
    @data ?= {}
    @name ?= 'Empty'
    @comment ?= ''
    @viewId ?= '_block'

    $block = $($.render(
      $("##{@viewId}").html(), viewContext()
    ))
    @svg = Snap.parse($block.html()).select('.block-svg')
    @dom = $block.find('.block-dom')
    partial = $("##{@partialId}").html()
    @dom.append(partial)

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

  onAppendTo: (svg, dom) ->
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

  

