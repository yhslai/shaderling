#= require ../Block

class Vertices extends Block
  constructor: (geometry) ->
    @inPortTypes = []
    @outPortTypes = [
      { type: 'collection@vect3#vertex' }
    ]
    @id = 'vertices'
    @data = geometry.vertices

    super 

window.Vertices = Vertices



