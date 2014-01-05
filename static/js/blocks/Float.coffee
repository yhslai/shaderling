#= require ../Block
#= require Constant

ID = 'float'

class Float extends Constant
  constructor: (args) ->
    @inPortTypes = []
    @outPortTypes = [
      { type: 'float', modifier: 'const' }
    ]
    super 
  
Block.blockDict[ID] = Float
window.Float = Float



