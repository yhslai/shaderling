#= require ../Block
#= require BinaryOperator

ID = '/'

class Divide extends BinaryOperator
  constructor: () ->
    @id = ID
    @operator = '/'

    super 

Block.blockDict[ID] = Divide
window.Multiple = Multiple



