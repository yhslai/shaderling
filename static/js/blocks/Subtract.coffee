#= require ../Block
#= require BinaryOperator

ID = '-'

class Subtract extends BinaryOperator
  constructor: () ->
    @id = Subtract
    @operator = '-'

    super 

Block.blockDict[ID] = Subtract
window.Subtract = Subtract



