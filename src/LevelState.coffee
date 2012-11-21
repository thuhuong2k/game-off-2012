LevelState = (levelData) ->

  forEach = (type, callback) ->
    result = []
    for layer, z in blockArray
      for row, y in layer
        for block, x in row
          if block.type is type
            result.push callback(block, x, y, z)
    return result

  forEachBlock = (callback) ->
    for layer, z in blockArray
      for row, y in layer
        for block, x in row
          callback(block, x, y, z)

  forEachBlockInLayer = (layer, callback) ->
    for row, y in blockArray[layer]
      for block, x in row
        callback(block, x, y)

  blockAt = (x, y, z) ->
    if x < 0 or x >= width then return new EmptyBlock
    if y < 0 or y >= depth then return new EmptyBlock
    if z < 0 or z >= height then return new EmptyBlock
    return blockArray[z][y][x]

  blockBelow = (x, y, z) ->
    while --z >= 0
      block = blockAt(x, y, z)
      if block.type isnt 'empty' then return block
    return new EmptyBlock

  player = null

  blockArray =  for layer, z in levelData
		              for row, y in layer
                    for block, x in row
                      switch block
                        when 'O' then new SolidBlock
                        when 'X' then new PlatformBlock
                        when 'B' then new BoxBlock
                        when '^' then new LiftBlock
                        when 'S' then player = new Player(x, y, z)
                        else new EmptyBlock

  height = blockArray.length
  depth = blockArray[0].length
  width = blockArray[0][0].length

  forEach 'lift', (lift, x, y, z) ->
    below = blockBelow(x, y, z)
    if below.type is 'lift'
      below.stop = z
      blockArray[z][y][x] = new EmptyBlock

  @height = height
  @depth = depth
  @width = width
  @player = player

  @forEach = forEach
  @forEachBlock = forEachBlock
  @forEachBlockInLayer = forEachBlockInLayer
  @blockAt = blockAt
  @blockBelow = blockBelow

  return

EmptyBlock = ->
  @type = 'empty'
  @static = false
  return

SolidBlock = ->
  @type = 'solid'
  @static = true
  return

PlatformBlock = ->
  @type = 'platform'
  @static = true
  return

BoxBlock = ->
  @type = 'box'
  @static = false
  return

LiftBlock = (x, y, z) ->
  @type = 'lift'
  @static = false
  @position = [x, y, z]
  @start = z
  @stop = z
  return

Player = (x, y, z) ->
  @type = 'player'
  @static = false
  @position = [x, y, z]
  return