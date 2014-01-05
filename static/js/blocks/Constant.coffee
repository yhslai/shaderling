#= require ../Block

class Constant extends Block
  constructor: (args) ->
    @updateData(args)
    super

  updateData: (args) ->
    @data = args
    @id = "#{@outPortTypes[0].type}(#{@data.join(',')})"

  populateStatements: (stage, statements) ->
    super
    outPort = @outPorts[0]
    if outPort.isUsed()
      statements.declarationPart.push(
        "const #{outPort.type.type} #{outPort.name} = #{@id}")

  
window.Constant = Constant



