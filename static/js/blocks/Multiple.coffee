#= require ../Block
#= require BinaryOperator

ID = '*'

class Multiple extends BinaryOperator
  constructor: () ->
    @id = ID
    @operator = '*'

    super 

Block.blockDict[ID] = Multiple
window.Multiple = Multiple



