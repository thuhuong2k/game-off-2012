LevelView = ->
  scene = new e3d.Scene
  staticModel = null

  camera = new e3d.Camera
  camera.distance = 16
  camera.rotation = [0.5, 0, 0]
  scene.camera = camera

  e3d.scene = scene

  @update = (levelState) ->
    if staticModel is null
      buildStaticModel(levelState)
      camera.position = [ levelState.width / 2
                          levelState.depth / 2
                          levelState.height / 2 ]
  
  # Makes a quadrangle out of two triangles
  # Vertex positions should be specified in the following order:
  # 1-----2
  # |   / |
  # | /   |
  # 3-----4
  makeQuad = (positions, color) ->
    p = positions
    r = color[0]
    g = color[1]
    b = color[2]
    #     |         position         | texcoord | color  |
    v = [ [ p[0][0], p[0][1], p[0][2],   0, 0,   r, g, b ]
          [ p[1][0], p[1][1], p[1][2],   1, 0,   r, g, b ]
          [ p[2][0], p[2][1], p[2][2],   0, 1,   r, g, b ]
          [ p[3][0], p[3][1], p[3][2],   1, 1,   r, g, b ] ]
    #               |   triangle 1   |   triangle 2   |
    return [].concat(v[0], v[1], v[2], v[3], v[2], v[1])
  
  # Creates the left face of a cube at [x, y, z]
  makeLeftFace = (x, y, z) ->
    positions = [ [x, y, z+1], [x, y+1, z+1], [x, y, z], [x, y+1, z] ]
    color = [0.7, 0.7, 0.7]
    return makeQuad(positions, color)
  
  # Creates the right face of a cube at [x, y, z]
  makeRightFace = (x, y, z) ->
    positions = [ [x+1, y+1, z+1], [x+1, y, z+1], [x+1, y+1, z], [x+1, y, z] ]
    color = [0.8, 0.8, 0.8]
    return makeQuad(positions, color)
  
  # Creates the back face of a cube at [x, y, z]
  makeBackFace = (x, y, z) ->
    positions = [ [x+1, y, z+1], [x, y, z+1], [x+1, y, z], [x, y, z] ]
    color = [0.6, 0.6, 0.6]
    return makeQuad(positions, color)
  
  # Creates the front face of a cube at [x, y, z]
  makeFrontFace = (x, y, z) ->
    positions = [ [x, y+1, z+1], [x+1, y+1, z+1], [x, y+1, z], [x+1, y+1, z] ]
    color = [0.9, 0.9, 0.9]
    return makeQuad(positions, color)
  
  # Creates the top face of a cube at [x, y, z]
  makeTopFace = (x, y, z) ->
    positions = [ [x, y, z+1], [x+1, y, z+1], [x, y+1, z+1], [x+1, y+1, z+1] ]
    color = [1.0, 1.0, 1.0]
    return makeQuad(positions, color)
  
  buildStaticModel = (levelState) ->
    side = []
    solidTop = []
    platformTop = []
    
    levelState.forEachBlock (block, x, y, z) ->
      if not block.empty
        leftBlock = levelState.blockAt(x-1, y, z)
        rightBlock = levelState.blockAt(x+1, y, z)
        backBlock = levelState.blockAt(x, y-1, z)
        frontBlock = levelState.blockAt(x, y+1, z)
        topBlock = levelState.blockAt(x, y, z+1)
        if leftBlock.empty then side = side.concat(makeLeftFace(x, y, z))
        if rightBlock.empty then side = side.concat(makeRightFace(x, y, z))
        if backBlock.empty then side = side.concat(makeBackFace(x, y, z) )
        if frontBlock.empty then side = side.concat(makeFrontFace(x, y, z))
        if topBlock.empty then side = side.concat(makeTopFace(x, y, z))
    
    staticModel = new e3d.Object
    staticModel.meshes = [new e3d.Mesh(side)]
    
    scene.objects = [staticModel]
  
  return
