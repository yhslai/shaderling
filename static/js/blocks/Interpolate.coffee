#= require ../Block

ID = 'I'

class Interpolate extends Block
  constructor: () ->
    @inPortTypes = [
      { type: 'anyAttritube' }
    ]
    @outPortTypes = [
      { type: 'none', hidden: true }
    ]
    @id = ID

    super 

  onPortChange: (thisPort, otherPort) ->
    super

    if otherPort?
      if thisPort is @inPorts[@inPorts.length-1]
        thisPort.type = otherPort.type
        newIn = new Port(@, @inPortTypes[0], 'in')
        @inPorts.push(newIn)
        @appendPort(newIn)
        newOut = new Port(@, @varyingType(otherPort.type), 'out')
        @outPorts.splice(@outPorts.length - 1, 0, newOut)
        @appendPort(newOut)
    else
      if thisPort.kind is 'in'
        index = @inPorts.indexOf(thisPort)
        if index isnt @inPorts.length - 1
          @removePort(thisPort)
          @removePort(@outPorts[index])
          @inPorts.splice(index, 1)
          @outPorts.splice(index, 1)

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

Block.blockDict[ID] = Interpolate
window.Interpolate = Interpolate



