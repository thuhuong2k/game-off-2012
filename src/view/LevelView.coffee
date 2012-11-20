# LevelView constructor
LevelView = ->
  camera = new e3d.Camera
  camera.distance = 12
  camera.rotation = [0.5, 0, 0]
  
  scene = new e3d.Scene
  scene.camera = camera
  
  imagefiles =
    'sky': ['/tex/sky.png']
    'level': ['/tex/wall.png', '/tex/floor.png', '/tex/platform.png']
    'box': ['/tex/box.png']
    'lift': ['/tex/lift.png', '/tex/lifttop.png']
  
  loadImageFiles imagefiles, (images) ->
    setSkyTextures(createTextures(images['sky']))
    setLevelTextures(createTextures(images['level']))
    setBoxTextures(createTextures(images['box']))
    setLiftTextures(createTextures(images['lift']))
    e3d.scene = scene
  
  currState = null

  @update = (levelState) ->
    if levelState isnt currState
      currState = levelState
      center = [ levelState.width / 2
                 levelState.depth / 2
                 levelState.height / 2 ]
      camera.position = center
      skySphere = new SkyObject
      skySphere.position = center
      levelModel = new StaticLevelObject(levelState)
      boxGroup = new e3d.Object
      boxGroup.children = levelState.forEach 'box',
                                             (box, x, y, z) ->
                                               new BoxObject(x, y, z)
      liftGroup = new e3d.Object
      liftGroup.children = levelState.forEach 'lift',
                                              (lift, x, y, z) ->
                                                new LiftObject(x, y, z)
      objects = [skySphere, levelModel, boxGroup, liftGroup]
      
      scene.objects = objects
  
  return
