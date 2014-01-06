#= require Port

class Block
  constructor: () ->
    self = @
    $.observable(self)

    self.on('appendTo', @onAppendTo)
    self.on('portChange', @onPortChange)
    self.on('refresh', @onRefresh)

    viewContext = () ->
      id: self.id
      data: self.data
      comment: self.comment
      editable: if self.id is 'Empty' or self instanceof Constant then 'contenteditable' else ''

    @uuid = Shaderling.Utils.generateUUID(12)
    @inPortTypes ?= []
    @outPortTypes ?= []
    @id ?= 'Empty'
    @data ?= {}
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

    idDom = @dom.find('.block-id')
    idDom.on('keydown', (e) ->
      if e.which is 13
        $(@).blur()
        false
    )
    idDom.on('blur', ->
      match = $(@).text().match(/([^,\(\)]*)(\(.*\))?/)
      klassName = match[1]
      argsStr = match[2]
      klass = Block.blockDict[klassName]

      args = []
      argPattern = /[-+]?[0-9]*\.?[0-9]+/g
      while (result = argPattern.exec(argsStr))?
        args.push(parseFloat(result[0]))

      if klass?
        if self.constructor is klass
          self.updateData(args)
          Shaderling.refresh()
        else
          self.createNewBlock(klass, args)
      else
        $(@).text('Empty')
    )

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

    @inPorts = @inPortTypes.map((p) -> new Port(self, p, 'in'))
    @outPorts = @outPortTypes.map((p) -> new Port(self, p, 'out'))
    @inPorts.forEach((p) -> self.appendPort(p))
    @outPorts.forEach((p) -> self.appendPort(p))
    @locateAllPorts()

  appendPort: (port) ->
    @svg.append(port.svg)

  removePort: (port) ->
    port.connections.forEach((c) -> c.remove())
    port.svg.remove()

  usedInPorts: () ->
    @inPorts.filter((p) -> p.connectedPort()?)

  usedOutPorts: () ->
    @outPorts.filter((p) ->
      p.connectedPort()?)

  locateAllPorts: () ->
    self = @

    @forAllPorts((p, index, array) ->
      p.locate(index, array.length, self.rectAttr('width'), self.rectAttr('height')))

  forAllPorts: (f) ->
    @inPorts.forEach(f)
    @outPorts.forEach(f)

  onAppendTo: (svg, dom) ->
    @locateDom()

  onPortChange: (thisPort, otherPort) ->

  onRefresh: () ->

  createNewBlock: (klass, args) ->
    
    newBlock = new klass(args)
    Shaderling.appendBlock(newBlock)
    newBlock.move(@realPos.x, @realPos.y)
    Shaderling.removeBlock(@)

  move: (x, y) ->
    @svg.transform("t#{x},#{y}")
    @realPos = { x: x, y: y }
    @locateDom()
    @locateAllPorts()

  locateDom: () ->
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

  changeComment: (comment) ->
    @comment = comment
    @dom.find('.block-comment').text(comment)

  populateStatements: (stage, statements) ->
    @forAllPorts((p) -> p.updateName())


Block.blockDict = {}

window.Block = Block

  

