#= require ../Block
#= require AttributesBlock

class Colors extends AttributesBlock
  constructor: (geometry) ->
    @inPortTypes = []
    @outPortTypes = [
      { type: 'vec3', modifier: 'attribute', annotation: 'color' }
    ]
    @id = 'colors'
    @data = []
    for face in geometry.faces
      @data[face.a] = face.vertexColors[0]
      @data[face.b] = face.vertexColors[1]
      @data[face.c] = face.vertexColors[2]

    super 

window.Colors = Colors



