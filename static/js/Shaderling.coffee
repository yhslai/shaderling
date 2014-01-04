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

    model = JSON.parse($('#cube_model').html())
    loader = new THREE.JSONLoader(true);
    geometry = loader.parse(model)
    b0 = new Preview()
    b1 = new Vertices(geometry)
    b2 = new Faces(geometry)
    b3 = new Combinator()

    b1.move(200, 20)
    b2.move(340, 20)
    b3.move(270, 80)
    b0.move(200, 160)
    @appendBlock(b0)
    @appendBlock(b1)
    @appendBlock(b2)
    @appendBlock(b3)

    @selectedPort = null

  appendBlock: (block) ->
    @svg.append(block.svg)
    @dom.append(block.dom)
    block.trigger('appendTo', @svg, @dom)

window.Shaderling = new Shaderling # Singleton

  

