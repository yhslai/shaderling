#= require Block
#= require_tree blocks

class Shaderling
  constructor: () ->
    @blocks = []
    @svg = Snap('#main')
    @dom = $('#main-container')

  init: () ->
    self = this
    resizeSvg = -> 
      self.dom.attr(
        width: $('body').width()
        height: $('body').height()
      )
    $(window).on('resize', resizeSvg)
    resizeSvg()

    b1 = new Vertices(JSON.parse($('#cube_model').html()))
    b2 = new Preview()

    b1.move(200, 20)
    b2.move(200, 160)
    @appendBlock(b1)
    @appendBlock(b2)

  appendBlock: (block) ->
    @svg.append(block.svg)
    @dom.append(block.dom)
    block.trigger('appendTo', @svg, @dom)

window.Shaderling = Shaderling

  

