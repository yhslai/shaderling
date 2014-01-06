#= require ../Block

class AttributesBlock extends Block
  constructor: (geometry) ->
    super 
    
    @nameDom = $($.render(
      $("#_name_partial").html(), { name: @id, id: @id } 
    ))
    @dom.append(@nameDom)

  populateStatements: (stage, statements) ->
    super
    self = @
    outPort = @outPorts[0]
    if outPort.isUsed()
      type = outPort.type
      statements.declarationPart.push("attribute #{type.type} #{@attributeName()}")
      statements.mainPart.push("#{type.type} #{outPort.name} = #{@attributeName()}")

  attributeName: (newName) ->
    if newName? then @nameDom.text(newName) else @nameDom.text()

  attributeType: () ->
    type = @outPorts[0].type
    Shaderling.Utils.shortTypeName(type)


window.AttributesBlock = AttributesBlock



