#= require GLSL_ES

class GLSL_ES.CodeGenerator
  constructor: (@statements) ->

  generateShader: (outputBlock) ->
    visited = {}
    fragmentBlocks = []
    vertexBlocks = []

    iter = (block, stage) ->
      visited[block.uuid] = true
      block.inPorts.forEach((p) ->
        otherBlock = p.connectedPort()?.block
        if otherBlock?
          if not visited[otherBlock.uuid]?
            if block instanceof Interpolate
              iter(otherBlock, 'vertex')
            else
              iter(otherBlock, stage)
      )
      if stage is 'fragment'
        fragmentBlocks.push(block)
        if block instanceof Interpolate
          vertexBlocks.push(block)
      else
        vertexBlocks.push(block)

    iter(outputBlock, 'fragment')

    vertexStatements = { mainPart: [], declarationPart: [] }
    vertexBlocks.forEach((b) -> b.populateStatements('vertex', vertexStatements) )
    fragmentStatements = { mainPart: [], declarationPart: [] }
    fragmentBlocks.forEach((b) -> b.populateStatements('fragment', fragmentStatements) )

    positionPort = outputBlock.inPorts[0]
    colorPort = outputBlock.inPorts[1]

    vertexStatements.mainPart.push("gl_Position = projectionMatrix * modelViewMatrix * vec4(#{positionPort.name}, 1.0)")
    fragmentStatements.mainPart.push("gl_FragColor = vec4(#{colorPort.name}, 1.0)")

    vertexShader= @statementsToCode(vertexStatements)
    fragmentShader = @statementsToCode(fragmentStatements)

    console.log("Vertex Shader: ")
    console.log(vertexShader)

    console.log("Fragment Shader: ")
    console.log(fragmentShader)

    {
      vertexShader: vertexShader
      fragmentShader: fragmentShader
    }

  statementsToCode: (statements) ->
    declarationCode = statements.declarationPart.map((s)->s+';').join('\n')
    mainCode = statements.mainPart.map((s)->'\t'+s+';').join('\n')

    """
    #{declarationCode}

    void main() {
      #{mainCode}
    }
    """


