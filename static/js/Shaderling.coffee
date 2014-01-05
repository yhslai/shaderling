#= require Block
#= require_tree blocks
#= require_tree GLSL_ES

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

    $('.add-button').on('click', -> self.createEmptyBlock())

    model = JSON.parse($('#cube_model').html())
    loader = new THREE.JSONLoader(true);
    geometry = loader.parse(model).geometry
    console.log(model,loader.parse(model),geometry)
    b0 = new Preview()
    b1 = new Positions(geometry)
    b2 = new Faces(geometry)
    b3 = new Interpolate()
    b4 = new Colors(geometry)
    b5 = new Output()

    b1.move(200, 20)
    b2.move(500, 20)
    b3.move(270, 80)
    b4.move(340, 20)
    b5.move(340, 80)
    b0.move(200, 160)
    @appendBlock(b0)
    @appendBlock(b1)
    @appendBlock(b2)
    @appendBlock(b3)
    @appendBlock(b4)
    @appendBlock(b5)

    @selectedPort = null

  createEmptyBlock: () ->
    block = new Block()
    block.move(900, 150)
    @appendBlock(block)

  appendBlock: (block) ->
    @blocks.push(block)
    @svg.append(block.svg)
    @dom.append(block.dom)
    block.trigger('appendTo', @svg, @dom)

  removeBlock: (block) ->
    index = @blocks.indexOf(block)
    if index isnt -1
      @blocks.splice(index, 1)
      block.svg.remove()
      block.dom.remove()
      block.trigger('removeFrom', @svg, @dom)

  refresh: () ->
    @blocks.forEach((b) -> b.trigger('refresh'))

window.Shaderling = new Shaderling # Singleton

  

