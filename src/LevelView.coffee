LevelView = ->
  scene = new e3d.Scene
  staticModel = null

  camera = new e3d.Camera;
  camera.position = [0,0,0];
  camera.distance = 16  
  scene.camera = camera;

  e3d.scene = scene

  e3d.onrender = ->
    camera.rotation = vec.add(camera.rotation, [0.005, 0.01, 0.007]);

  @update = (levelState) ->
    if staticModel is null
      buildStaticModel(levelState.blockArray)



  buildStaticModel = (blockArray) ->
    side = []
    solidTop = []
    platformTop = []

    for layer, z in blockArray
      for row, y in layer
        for block, x in row
          if not block.empty
            leftBlock = blockArray[z][y][x-1]
            if not leftBlock? or leftBlock.empty
              side = side.concat [x,y+0,z+0, 0,1, 1,1,1]
              side = side.concat [x,y+1,z+0, 1,1, 1,1,1]
              side = side.concat [x,y+1,z+1, 1,0, 1,1,1]

              side = side.concat [x,y+0,z+0, 0,1, 1,1,1]
              side = side.concat [x,y+1,z+1, 1,0, 1,1,1]
              side = side.concat [x,y+0,z+1, 0,0, 1,1,1]

    console.log "side = " + side

    staticModel = new e3d.Object
    staticModel.meshes = [new e3d.Mesh(side)]

    scene.objects = [staticModel]

  return
