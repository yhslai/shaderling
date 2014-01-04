#= require ../Block

class Faces extends Block
  constructor: (geometry) ->
    @inPorts = []
    @outPorts = [
      { type: 'collection@face' }
    ]
    @id = 'faces'
    @data = geometry.faces

    super 

window.Faces = Faces



