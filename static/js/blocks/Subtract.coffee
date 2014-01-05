#= require ../Block
#= require BinaryOperator

ID = '-'

class Subtract extends BinaryOperator
  constructor: () ->
    @id = ID
    @operator = '-'

    super 

Block.blockDict[ID] = Subtract
window.Subtract = Subtract



