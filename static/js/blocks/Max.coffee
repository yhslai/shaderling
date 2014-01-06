#= require ../Block

ID = 'max'

class Max extends Block
  constructor: () ->
    @inPortTypes = [
      { type: 'float' }
      { type: 'float' }
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
      statements.mainPart.push("#{outPort.type.type} #{outPort.name} = max(#{firstInPort.name}, #{secondInPort.name})")

Block.blockDict[ID] = Max  
window.Max = Max



