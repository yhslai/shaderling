#= require ../Block
#= require Constant

ID = 'vec3'

class Vec3 extends Constant
  constructor: (args) ->
    @inPortTypes = []
    @outPortTypes = [
      { type: 'vec3', modifier: 'const' }
    ]
    @id = ID
    @data = args

    super 
  
Block.blockDict[ID] = Vec3
window.Vec3 = Vec3



