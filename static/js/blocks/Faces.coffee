#= require ../Block

class Faces extends Block
  constructor: (geometry) ->
    @inPortTypes = []
    @outPortTypes = [
      { type: 'face' }
    ]
    @id = 'faces'
    @data = geometry.faces

    super 

window.Faces = Faces



