#= require Block

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

    @createBlock()

  createBlock: () ->
    block = new Block
    block.appendTo(@svg, @dom)

window.Shaderling = Shaderling

  

