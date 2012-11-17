# LevelView constructor
LevelView = ->
  staticModel = new e3d.Object

  camera = new e3d.Camera
  camera.distance = 12
  camera.rotation = [0.5, 0, 0]
  
  scene = new e3d.Scene
  scene.camera = camera
  scene.objects = [staticModel]
  
  loadTextures ['ground', 'wall', 'floor', 'platform'], (textures) ->
    staticModel.textures = textures
    e3d.scene = scene
  
  currState = null

  @update = (levelState) ->
    if levelState isnt currState
      currState = levelState
      staticModel.meshes = buildStaticLevelModel(levelState)
      camera.position = [ levelState.width / 2
                          levelState.depth / 2
                          levelState.height / 2 ]
  
  return
