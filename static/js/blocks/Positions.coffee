#= require ../Block

class Positions extends Block
  constructor: (geometry) ->
    @inPortTypes = []
    @outPortTypes = [
      { type: 'vec3', annotation: 'position' }
    ]
    @id = 'positions'
    @data = geometry.vertices

    super

  populateStatements: (stage, statements) ->
    super
    self = @
    outPort = @outPorts[0]
    if outPort.isUsed()
      type = outPort.type
      statements.mainPart.push("vec3 #{outPort.name} = position")

window.Positions = Positions



