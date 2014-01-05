#= require ../Block
#= require BinaryOperator

ID = '+'

class Add extends BinaryOperator
  constructor: () ->
    @id = ID
    @operator = '+'

    super 

Block.blockDict[ID] = Add
window.Add = Add



