levelTextures = []

setLevelTextures = (textures) ->
  for texture, index in textures
    levelTextures[index] = texture

StaticLevelObject = (levelState) ->
  width = levelState.width
  depth = levelState.depth
  
  # ground = []
  side = []
  solidTop = []
  platformTop = []
  
  ###
  # Construct ground plane
  levelState.forEachBlockInLayer 0, (block, x, y) ->
    if not block.static
      ground = ground.concat(makeTopFace(x, y, -1))
    if x is 0 # Left edge
      ground = ground.concat(makeTopFace(-1, y, -1))
    if x is width - 1 # Right edge
      ground = ground.concat(makeTopFace(x+1, y, -1))
    if y is 0 # Back edge
      ground = ground.concat(makeTopFace(x, -1, -1))
    if y is depth - 1 # Front edge
      ground = ground.concat(makeTopFace(x, y+1, -1))
    if x is 0 and y is 0 # Back-left corner
      ground = ground.concat(makeTopFace(-1, -1, -1))
    if x is width - 1 and y is 0 # Back-right corner
      ground = ground.concat(makeTopFace(x+1, -1, -1))
    if x is 0 and y is depth - 1 # Front-left corner
      ground = ground.concat(makeTopFace(-1, y+1, -1))
    if x is width - 1 and y is depth - 1 # Front right corner
      ground = ground.concat(makeTopFace(x+1, y+1, -1))
  ###
  
  # Construct level model
  levelState.forEachBlock (block, position) ->
    if block.static
      leftBlock  = levelState.blockAt(vec.add(position, [-1, 0, 0]))
      rightBlock = levelState.blockAt(vec.add(position, [ 1, 0, 0]))
      backBlock  = levelState.blockAt(vec.add(position, [ 0,-1, 0]))
      frontBlock = levelState.blockAt(vec.add(position, [ 0, 1, 0]))
      topBlock   = levelState.blockAt(vec.add(position, [ 0, 0, 1]))
      if not leftBlock.static  then side = side.concat(makeLeftFace(position))
      if not rightBlock.static then side = side.concat(makeRightFace(position))
      if not backBlock.static  then side = side.concat(makeBackFace(position) )
      if not frontBlock.static then side = side.concat(makeFrontFace(position))
      if not topBlock.static
        if block.type is 'solid' then solidTop = solidTop.concat(makeTopFace(position))
        if block.type is 'platform' then platformTop = platformTop.concat(makeTopFace(position))
  
  object = new e3d.Object
  object.meshes = [ new e3d.Mesh(side)
                    new e3d.Mesh(solidTop)
                    new e3d.Mesh(platformTop) ]
  object.textures = levelTextures
  return object
