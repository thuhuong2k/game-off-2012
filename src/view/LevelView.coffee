# LevelView constructor
LevelView = ->
  camera = new e3d.Camera
  camera.distance = 12
  camera.rotation = [0.5, 0, 0]
  
  scene = new e3d.Scene
  scene.camera = camera
  
  loadTextures ['ground', 'wall', 'floor', 'platform'], (textures) ->
    setLevelTextures(textures)
    loadTexture 'box', (texture) ->
      setBoxTexture( texture )
      e3d.scene = scene
  
  currState = null

  @update = (levelState) ->
    if levelState isnt currState
      currState = levelState
      camera.position = [ levelState.width / 2
                          levelState.depth / 2
                          levelState.height / 2 ]
      levelModel = new StaticLevelObject(levelState)
      boxGroup = new e3d.Object
      boxGroup.children = levelState.forEach 'box',
                                             (box, x, y, z) ->
                                               new BoxObject(x, y, z)
      objects = [levelModel, boxGroup]
      
      scene.objects = objects
  
  return
