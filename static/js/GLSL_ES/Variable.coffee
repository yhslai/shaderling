#= require GLSL_ES

class GLSL_ES.Variable
  constructor: (@type, @name) ->
    @name ?= @type.toString() + '_' + Shaderling.Utils.generateUUID(6)
    super 



