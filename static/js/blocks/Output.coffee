#= require ../Block
#= require_tree ../GLSL_ES

G = GLSL_ES

class Output extends Block
  constructor: () ->
    @inPortTypes = [
      { type: 'vec3', modifier: 'attribute', annotation: 'position' }
      { type: 'vec3', modifier: 'varying', annotation: 'color' }
    ]
    @outPortTypes = []
    @id = 'output'
    @data = {}
    @comment = ''
    @partialId = "_output"

    super 

  onRefresh: () ->
    (new G.CodeGenerator).generateShader(@)

window.Output = Output



