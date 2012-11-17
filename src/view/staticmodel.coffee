buildStaticLevelModel = (levelState) ->
  width = levelState.width
  depth = levelState.depth
  
  ground = []
  side = []
  solidTop = []
  platformTop = []
  
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
  
  # Construct level model
  levelState.forEachBlock (block, x, y, z) ->
    if block.static
      leftBlock = levelState.blockAt(x-1, y, z)
      rightBlock = levelState.blockAt(x+1, y, z)
      backBlock = levelState.blockAt(x, y-1, z)
      frontBlock = levelState.blockAt(x, y+1, z)
      topBlock = levelState.blockAt(x, y, z+1)
      if not leftBlock.static then side = side.concat(makeLeftFace(x, y, z))
      if not rightBlock.static then side = side.concat(makeRightFace(x, y, z))
      if not backBlock.static then side = side.concat(makeBackFace(x, y, z) )
      if not frontBlock.static then side = side.concat(makeFrontFace(x, y, z))
      if not topBlock.static
        if block.type is 'solid' then solidTop = solidTop.concat(makeTopFace(x, y, z))
        if block.type is 'platform' then platformTop = platformTop.concat(makeTopFace(x, y, z))
  
  return [ new e3d.Mesh(ground)
           new e3d.Mesh(side)
           new e3d.Mesh(solidTop)
           new e3d.Mesh(platformTop) ]
