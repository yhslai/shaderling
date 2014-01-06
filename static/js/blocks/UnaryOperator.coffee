#= require ../Block

class UnaryOperator extends Block
  constructor: () ->
    super 

  populateStatements: (stage, statements) ->
    super
    self = @
    outPort = @outPorts[0]
    inPort = @inPorts[0]
    if inPort.isUsed()
      statements.mainPart.push("#{outPort.type.type} #{outPort.name} = #{@operator}(#{inPort.name})")

  
window.UnaryOperator = UnaryOperator



