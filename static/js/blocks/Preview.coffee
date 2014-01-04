#= require ../Block

class Preview extends Block
  WIDTH = 400
  HEIGHT = 300

  VIEW_ANGLE = 45
  ASPECT = WIDTH / HEIGHT
  NEAR = 0.1
  FAR = 10000

  constructor: (@width=WIDTH, @height=HEIGHT) ->
    @inPortTypes = []
    @outPortTypes = []
    @id = 'preview'
    @data = {}
    @comment = ''
    @partialId = "_preview"

    super 

    @on('dataChange', @onDataChange)

  onAppendTo: (svg, dom) ->
    super
    @initScene()
    @trigger('dataChange', {})

  initScene: () ->
    @renderer = new THREE.WebGLRenderer()
    @camera = new THREE.PerspectiveCamera(VIEW_ANGLE, ASPECT, NEAR, FAR)
    @scene = new THREE.Scene()

    @camera.position.z = 300

    @renderer.setSize(@width, @height)

    $container = @dom.find('.preview-container')
    $container.append(@renderer.domElement)

    $container.css(
      left: -(@width - @dom.width()) / 2
    )

  onDataChange: (data) ->
    radius = 50
    segments = 16
    rings = 16;

    sphereMaterial = new THREE.MeshLambertMaterial(
      color: 0xCC0000
    )

    sphere = new THREE.Mesh(
      new THREE.SphereGeometry(radius, segments, rings),
    sphereMaterial);

    @scene.add(sphere);

    pointLight = new THREE.PointLight( 0xFFFFFF )

    pointLight.position.x = 10;
    pointLight.position.y = 50;
    pointLight.position.z = 130;

    @scene.add(pointLight);

    @renderer.setClearColor( 0xBBBBBB, 1 );
    @renderer.render(@scene, @camera)


window.Preview = Preview



