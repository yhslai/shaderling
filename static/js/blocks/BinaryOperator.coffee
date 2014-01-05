#= require ../Block

class BinaryOperator extends Block
  constructor: () ->
    @inPortTypes = [
      { type: 'any' }
      { type: 'any' }
    ]
    @outPortTypes = [
      { type: 'any' }
    ]

    super 

  onPortChange: (thisPort, otherPort, oldOther) ->
    super

    if otherPort?
      firstType = @inPorts[0].connectedPort()?.type
      secondType = @inPorts[1].connectedPort()?.type
      if firstType? and secondType?
        resultType = {
          type: if secondType.type is 'float' then firstType.type else secondType.type
          annotation: firstType.annotation ? secondType.annotation
        }
        @outPorts[0].type = resultType

  populateStatements: (stage, statements) ->
    super
    self = @
    outPort = @outPorts[0]
    firstInPort = @inPorts[0]
    secondInPort = @inPorts[1]
    if firstInPort.isUsed() and secondInPort.isUsed()
      statements.mainPart.push("#{outPort.type.type} #{outPort.name} = #{firstInPort.name} #{@operator} #{secondInPort.name}")

  
window.BinaryOperator = BinaryOperator



