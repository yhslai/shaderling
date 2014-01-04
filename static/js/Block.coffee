#= require Port

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

    @inPortTypes ?= []
    @outPortTypes ?= []
    @id ?= 'block'
    @data ?= {}
    @name ?= 'Empty'
    @comment ?= ''
    @viewId ?= '_block'
    @ports = []

    $block = $($.render(
      $("##{@viewId}").html(), viewContext()
    ))
    @svg = Snap.parse($block.html()).select('.block-svg')
    @blockRect = @svg.select('.block-rect')
    @dom = $block.find('.block-dom')
    partial = $("##{@partialId}").html()
    @dom.append(partial)

    @realPos = { x: 0, y: 0 }
    oldPos = {}
    @blockRect.drag(((dx, dy, posx, posy) -> 
      self.move(oldPos.x + dx, oldPos.y + dy)
    ), ((posx, posy) ->
      oldPos = {
        x: self.realPos.x
        y: self.realPos.y
      }
    ), ( ->
    ))

    @initPorts()

  initPorts: () ->
    self = @

    init = (p, index, array) ->
      self.svg.append(p.svg)
      p.locate(index, array.length, self.rectAttr('width'), self.rectAttr('height'))

    @inPorts = @inPortTypes.map((p) -> new Port(self, p, 'in'))
    @outPorts = @outPortTypes.map((p) -> new Port(self, p, 'out'))
    @inPorts.forEach(init)
    @outPorts.forEach(init)

  onAppendTo: (svg, dom) ->
    @relocateDom()

  move: (x, y) ->
    @svg.transform("t#{x},#{y}")
    @realPos = { x: x, y: y }
    @relocateDom()

  relocateDom: () ->
    $svg = $(@svg.node)
    window.svg = $svg
    offset = $svg.offset()
    @dom.offset(
      left: offset.left + $svg.width() / 2
      top: offset.top
    )
    @dom.css(
      width: @rectAttr('width')
      height: @rectAttr('height')
    )

  rectAttr: (attrName) ->
    parseInt(@blockRect.attr(attrName))


window.Block = Block

  

