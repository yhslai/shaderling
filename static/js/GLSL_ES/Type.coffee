#= require GLSL_ES

class GLSL_ES.Type
  constructor: (data) ->
    @type = data.type
    @modifier = data.modifier
    @annotation = data.annotation
    super 

  toString: () ->
    "#{@type}_#{@modifier}_#{@annotation}"



