#= require ../Block

class Interpolate extends Block
  constructor: () ->
    @inPortTypes = [
      { type: 'anyAttritube' }
    ]
    @outPortTypes = [
      { type: 'none', hidden: true }
    ]
    @id = 'I'

    super 

  onPortChange: (thisPort, otherPort, oldOther) ->
    super

    if otherPort?
      if not oldOther?
        if thisPort is @inPorts[@inPorts.length-1]
          thisPort.type = otherPort.type
          newIn = new Port(@, @inPortTypes[0], 'in')
          @inPorts.push(newIn)
          @appendPort(newIn)
          newOut = new Port(@, @varyingType(otherPort.type), 'out')
          @outPorts.splice(@outPorts.length - 1, 0, newOut)
          @appendPort(newOut)

    window.i = @
    @locateAllPorts()

  varyingType: (type) ->
    jQuery.extend({modifier: 'varying'}, type);

  populateStatements: (stage, statements) ->
    super if stage is 'vertex'
    self = @
    @outPorts.forEach((outPort, i) ->
      console.log(outPort)
      inPort = self.inPorts[i]
      if outPort.isUsed() and inPort.isUsed()
        type = inPort.type
        statements.mainPart.push("#{outPort.name} = #{inPort.name}") if stage is 'vertex'
        statements.declarationPart.push("varying #{type.type} #{outPort.name}")
    )

  


window.Interpolate = Interpolate



