#= require ../Block

ID = 'dot'

class Dot extends Block
  constructor: () ->
    @inPortTypes = [
      { type: 'vec3' }
      { type: 'vec3' }
    ]
    @outPortTypes = [
      { type: 'float' }
    ]
    @id = ID

    super 

  populateStatements: (stage, statements) ->
    super
    self = @
    outPort = @outPorts[0]
    firstInPort = @inPorts[0]
    secondInPort = @inPorts[1]
    if firstInPort.isUsed() and secondInPort.isUsed()
      statements.mainPart.push("#{outPort.type.type} #{outPort.name} = dot(#{firstInPort.name}, #{secondInPort.name})")

Block.blockDict[ID] = Dot  
window.Dot = Dot



