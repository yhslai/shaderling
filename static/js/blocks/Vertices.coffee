#= require ../Block

class Vertices extends Block
  constructor: (model) ->
    @inPorts = []
    @outPorts = [
      { type: 'collection@vect3#vertex' }
    ]
    @id = 'vertices'
    @data = model.vertices

    super 

window.Vertices = Vertices



