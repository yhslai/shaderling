#= require ../Block

ID = 'preview'

class Preview extends Block
  WIDTH = 400
  HEIGHT = 300

  VIEW_ANGLE = 45
  ASPECT = WIDTH / HEIGHT
  NEAR = 0.1
  FAR = 10000

  constructor: () ->
    @inPortTypes = [
      { type: 'vec3', modifier: 'attribute', annotation: 'position' }
      { type: 'vec3', modifier: 'varying', annotation: 'color' }
      { type: 'face', annotation: 'face' }
    ]
    @outPortTypes = []
    @id = ID
    @partialId = "_preview_partial"
    @width = WIDTH
    @height = HEIGHT

    super 

  onAppendTo: (svg, dom) ->
    super
    @initScene()
    @trigger('dataChange', {})

  initScene: () ->
    @renderer = new THREE.WebGLRenderer()
    @camera = new THREE.PerspectiveCamera(VIEW_ANGLE, ASPECT, NEAR, FAR)

    @camera.position.z = 300

    @renderer.setSize(@width, @height)
    @renderer.setClearColor( 0xFFFFFF, 1 );
    @renderer.clear();

    $container = @dom.find('.preview-container')
    $container.append(@renderer.domElement)

    $container.css(
      left: -(@width - @dom.width()) / 2
    )

  onRefresh: () ->
    positionsBlock = null
    attributesBlocks = []
    facesBlock = null

    visited = {}

    iter = (block) ->
      firstPortName = block.outPorts[0]?.name
      if block instanceof Positions
        positionsBlock = block
      else if block instanceof AttributesBlock
        attributesBlocks.push(block)
      else if block instanceof Faces
        facesBlock = block

      visited[block.uuid] = true
      block.inPorts.forEach((p) ->
        otherBlock = p.connectedPort()?.block
        if otherBlock?
          if not visited[otherBlock.uuid]?
            iter(otherBlock)
      )

    iter(@)

    geometry = new THREE.Geometry()
    geometry.vertices = positionsBlock.data
    geometry.faces = facesBlock.data
    geometry.verticesNeedUpdate = true
    geometry.elementsNeedUpdate = true

    attributes = {}
    attributesBlocks.forEach((b) ->
      attributes[b.attributeName()] = {
        type: b.attributeType()
        value: b.data
      }
    )

    generator = new GLSL_ES.CodeGenerator()
    shaders = generator.generateShader(@)

    shaderMaterial = new THREE.ShaderMaterial(
      uniforms: {}
      attributes:  attributes
      vertexShader: shaders.vertexShader
      fragmentShader: shaders.fragmentShader
    )

    mesh = new THREE.Mesh(
      geometry
      shaderMaterial
    );

    @scene = new THREE.Scene()
    @scene.add(mesh);

    @renderer.render(@scene, @camera)

Block.blockDict[ID] = Preview
window.Preview = Preview



