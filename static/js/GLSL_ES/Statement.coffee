#= require GLSL_ES

class GLSL_ES.Statement
  constructor: (@lhs, @rhs, @isDeclaration) ->
    super 

  toShaderCode: ->
    snippets = []
    snippets.push(@lhs.type.type)if @isDeclaration?
    snippets.push(@lhs.name)
    if @rhs?
      snippets.push('=')
      snippets.push(@rhs.toShaderCode())

    snippets.join(' ') + ';'



