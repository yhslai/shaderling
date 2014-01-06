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
    $realUploadButton = $('.real-upload-button') 
    $realUploadButton.on('change',  -> self.handleFileSelect(@.files[0]))
    $('.upload-button').on('click', -> $realUploadButton.trigger('click'))

    b0 = new Preview()
    b3 = new Interpolate()
    b5 = new Output()

    b0.move(500, 400)
    b3.move(500, 150)
    b5.move(800, 400)
    @appendBlock(b0)
    @appendBlock(b3)
    @appendBlock(b5)

    @selected = null

  createEmptyBlock: () ->
    block = new Block()
    block.move(1200 * (Math.random() / 5 + 0.8), 75 * (Math.random() / 5 + 0.8))
    @appendBlock(block)

  handleFileSelect: (file) ->
    self = @
    reader = new FileReader()
    reader.onload = (e) ->
      self.createBlocksByModel(JSON.parse(e.target.result), file.name)
    reader.readAsText(file)

  createBlocksByModel: (model, filename) ->
    basename = filename.replace(/\..+$/, '')
    loader = new THREE.JSONLoader(true);
    geometry = loader.parse(model).geometry
    pb = new Positions(geometry)
    cb = new Colors(geometry)
    nb = new Normals(geometry)
    fb = new Faces(geometry)
    pb.changeComment(basename)
    cb.changeComment(basename)
    nb.changeComment(basename)
    fb.changeComment(basename)
    cb.attributeName("#{cb.attributeName()}_#{basename}")
    nb.attributeName("#{nb.attributeName()}_#{basename}")
    pb.move(800, 50)
    cb.move(950, 50)
    nb.move(1100, 50)
    fb.move(1250, 50)
    @appendBlock(pb)
    @appendBlock(cb)
    @appendBlock(nb)
    @appendBlock(fb)

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

  

