#= require ../Block
#= require UnaryOperator

ID = 'normalize'

class Normalize extends UnaryOperator
  constructor: () ->
    @inPortTypes = [
      { type: 'vec3' }
    ]
    @outPortTypes = [
      { type: 'vec3' }
    ]

    @id = ID
    @operator = 'normalize'

    super 

Block.blockDict[ID] = Normalize
window.Normalize = Normalize



