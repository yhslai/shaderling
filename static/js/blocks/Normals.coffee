#= require ../Block
#= require AttributesBlock

class Normals extends AttributesBlock
  constructor: (geometry) ->
    @inPortTypes = []
    @outPortTypes = [
      { type: 'vec3', modifier: 'attribute', annotation: 'normal' }
    ]
    @id = 'normals'
    @data = []
    for face in geometry.faces
      @data[face.a] = face.vertexNormals[0]
      @data[face.b] = face.vertexNormals[1]
      @data[face.c] = face.vertexNormals[2]

    super 

window.Normals = Normals



