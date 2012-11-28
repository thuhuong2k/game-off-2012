class LevelView
  constructor: ->
    @camera = new Camera
    @camera.distance = 12
    @camera.rotation = [0.5, 0, 0]

    @scene = new e3d.Scene
    @scene.camera = @camera

    imagefiles =
      'sky': ['/textures/sky.png']
      'level': ['/textures/wall.png', '/textures/floor.png', '/textures/platform.png']
      'box': ['/textures/box.png']
      'lift': ['/textures/lift.png', '/textures/lifttop.png']
      'player': ['/textures/player.png']

    instance = this
    loadImageFiles imagefiles, (images) ->
      SkyObject.setTextures(createTextures(images['sky']))
      StaticLevelObject.setTextures(createTextures(images['level']))
      BoxObject.setTextures(createTextures(images['box']))
      LiftObject.setTextures(createTextures(images['lift']))
      PlayerObject.setTextures(createTextures(images['player']))
      e3d.scene = instance.scene

    @currState = null

  build: (levelState) ->
    center = [ levelState.width / 2
               levelState.depth / 2
               levelState.height / 2 ]

    @camera.position = center

    skySphere = new SkyObject
    skySphere.position = center

    levelModel = new StaticLevelObject(levelState)

    boxGroup = new e3d.Object
    boxGroup.children = levelState.forEach 'box',
                                           (box, position) ->
                                             new BoxObject(box)

    liftGroup = new e3d.Object
    liftGroup.children = levelState.forEach 'lift',
                                            (lift, x, y, z) ->
                                              new LiftObject(lift)

    @player = new PlayerObject(levelState.player)

    @scene.objects = [skySphere, levelModel, boxGroup, liftGroup, @player]

  update: (levelState) ->
    if levelState isnt @currState
      @currState = levelState
      @build(levelState)

      instance = this
      e3d.onrender = ->
        player = levelState.player
        camera = instance.camera
        diff = vec.sub(vec.add(player.position,[0.5, 0.5, 0.5]), camera.position)
        toAdd = vec.mul(diff, 0.05)
        camera.position = vec.add(camera.position, toAdd)
