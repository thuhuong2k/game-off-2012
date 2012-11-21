LevelState = (levelData) ->

  EmptyBlock = (x, y, z) ->
    @type = 'empty'
    @static = false
    @position = [x, y, z]

    @moveableToFrom = ->
      return blockBelow(@position[0], @position[1], @position[2]).type isnt 'empty'

    @moveToFrom = (position) ->
      block = blockAt(position[0], position[1], position[2])

      blockArray[position[2]][position[1]][position[0]] = this
      blockArray[@position[2]][@position[1]][@position[0]] = block

      block.position = @position
      @position = position


    return

  SolidBlock = ->
    @type = 'solid'
    @static = true

    @moveableToFrom = (position) ->
      return false

    return

  PlatformBlock = ->
    @type = 'platform'
    @static = true

    @moveableToFrom = (position) ->
      return false

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

    move = (direction) ->
      newPosition = vec.add(@position, direction)
      targetBlock = blockAt(newPosition[0], newPosition[1], newPosition[2])

      if targetBlock.moveableToFrom(@position)
        targetBlock.moveToFrom(from)
        return true
      else
        return false

    return

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

  movePlayer = (direction) ->

    switch direction
      when 'left'
        positionOffset = [-1,0,0]
      when 'up'
        positionOffset = [0,-1,0]
      when 'right'
        positionOffset = [1,0,0]
      when 'down'
        positionOffset = [0,1,0]

    player.move(positionOffset)


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
                        else new EmptyBlock(x, y, z)

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
