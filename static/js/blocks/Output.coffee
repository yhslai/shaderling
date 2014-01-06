#= require ../Block
#= require_tree ../GLSL_ES

G = GLSL_ES
ID = 'output'

class Output extends Block
  constructor: () ->
    self = @

    @inPortTypes = [
      { type: 'vec3', modifier: 'attribute', annotation: 'position' }
      { type: 'vec3', modifier: 'varying', annotation: 'color' }
    ]
    @outPortTypes = []
    @id = ID
    @data = {}
    @comment = ''
    @partialId = "_output_partial"

    super 

    $button = @dom.find('.output-button')
    $button.on('click', ->
      shader = (new G.CodeGenerator).generateShader(self)
      $('#output-modal .vertex-shader').text(shader.vertexShader)
      $('#output-modal .fragment-shader').text(shader.fragmentShader)
      $('#output-modal').show()
    )
    $(document).on('keydown', (e) ->
      if e.which is 27
        $('#output-modal').hide()
    )

  onRefresh: () ->
    (new G.CodeGenerator).generateShader(@)

Block.blockDict[ID] = Interpolate
window.Output = Output



