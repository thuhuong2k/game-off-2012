class EmptyBlock
  type: 'empty'
  static: false
  
  constructor: (@level, @position) ->
  
  move: -> return @level.blockBelow(@position) isnt 'empty'


class SolidBlock
  type: 'solid'
  static: true
  
  move: -> return false


class PlatformBlock
  type: 'platform'
  static: true
  
  move: -> return false


class BoxBlock
  type: 'box'
  static: false
  
  constructor: (@level, @position) ->
  
  move: (direction, force) ->
    if force >= 1
      here = @position
      next = vec.add(here, direction)
      if @level.blockAt(next).move(direction, force - 1)
        above = vec.add(here, [0,0,1])
        @level.blockAt(above).move(direction, force)
        @level.swapBlocksAt(here, next)
        return true
    return false


class LiftBlock
  type: 'lift'
  static: false
  
  constructor: (@level, @position) ->
    @bottom = @position[2]
    @top = @position[2]
  
  move: -> return false


class Player
  type: 'player'
  static: false
  
  constructor: (@level, @position) ->
  
  move: (direction) ->
    here = @position
    next = vec.add(here, direction)
    if @level.blockAt(next).move(direction, 1)
      @level.swapBlocksAt(here, next)
      return true
    return false


class LevelState extends Observable
  constructor: (levelData) ->
    @blockArray = for layer, z in levelData
                    for row, y in layer
                      for block, x in row
                        position = [x, y, z]
                        switch block
                          when 'O' then new SolidBlock
                          when 'X' then new PlatformBlock
                          when 'B' then new BoxBlock(this, position)
                          when '^' then new LiftBlock(this, position)
                          when 'S' then @player = new Player(this, position)
                          else new EmptyBlock(this, position)

    @height = @blockArray.length
    @depth = @blockArray[0].length
    @width = @blockArray[0][0].length
    
    instance = this
    @forEach 'lift', (lift, position) ->
      below = instance.blockBelow(position)
      if below.type is 'lift'
        below.top = position[z]
        instance.setBlockAt(position, new EmptyBlock)
  
  forEach: (type, callback) ->
    result = []
    for layer, z in @blockArray
      for row, y in layer
        for block, x in row
          if block.type is type
            result.push callback(block, [x, y, z])
    return result
  
  forEachBlock: (callback) ->
    for layer, z in @blockArray
      for row, y in layer
        for block, x in row
          callback(block, [x, y, z])
  
  blockAt: (position) ->
    [x, y, z] = position
    if x < 0 or x >= @width then return new EmptyBlock(this, position)
    if y < 0 or y >= @depth then return new EmptyBlock(this, position)
    if z < 0 or z >= @height then return new EmptyBlock(this, position)
    return @blockArray[z][y][x]
  
  blockBelow: (position) ->
    [x, y, z] = position
    until --z < 0
      block = @blockAt([x, y, z])
      if block.type isnt 'empty' then return block
    return new EmptyBlock(this, [x, y, z])
  
  setBlockAt: (position, block) ->
    block.level = this
    block.position = position
    [x, y, z] = position
    @blockArray[z][y][x] = block
  
  swapBlocksAt: (position1, position2) ->
    @setBlockAt(position1, @blockAt(position2))
    @setBlockAt(position2, @blockAt(position1))
  
  movePlayer: (direction) ->
    @player.move switch direction
                   when 'left'  then [-1, 0, 0]
                   when 'up'    then [ 0,-1, 0]
                   when 'right' then [ 1, 0, 0]
                   when 'down'  then [ 0, 1, 0]


###
LevelState = (levelData) ->

  EmptyBlock = (position) ->
    THIS = this
    
    THIS.type = 'empty'
    THIS.static = false
    THIS.position = position

    THIS.moveableToFrom = ->
      return blockBelow(THIS.position).type isnt 'empty'

    THIS.moveBlockHereFrom = (position) ->
      target = blockAt(position)

      setBlock(THIS, target.position)
      setBlock(target, THIS.position)

      target.position = THIS.position
      THIS.position = position

    return THIS

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

  Player = (position) ->
    @type = 'player'
    @static = false
    @position = position

    move = (direction) ->
      newPosition = vec.add(@position, direction)
      targetBlock = blockAt(newPosition[0], newPosition[1], newPosition[2])

      if targetBlock.moveableToFrom(@position)
        targetBlock.moveBlockHereFrom(from)
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

  blockAt = (position) ->
    x = position[0]
    y = position[1]
    z = position[2]
    if x < 0 or x >= width then return new EmptyBlock(position)
    if y < 0 or y >= depth then return new EmptyBlock(position)
    if z < 0 or z >= height then return new EmptyBlock(position)
    return blockArray[z][y][x]
  
  setBlock = (block, position) ->
    x = position[0]
    y = position[1]
    z = position[2]
    blockArray[z][y][x] = block
  
  blockBelow = (position) ->
    x = position[0]
    y = position[1]
    z = position[2]
    until --z < 0
      block = blockAt([x, y, z])
      if block.type isnt 'empty' then return block
    return new EmptyBlock([x, y, z])

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
                      position = [x, y, z]
                      switch block
                        when 'O' then new SolidBlock
                        when 'X' then new PlatformBlock
                        when 'B' then new BoxBlock
                        when '^' then new LiftBlock
                        when 'S' then player = new Player(position)
                        else new EmptyBlock(position)

  height = blockArray.length
  depth = blockArray[0].length
  width = blockArray[0][0].length

  forEach 'lift', (lift, x, y, z) ->
    below = blockBelow(x, y, z)
    if below.type is 'lift'
      below.stop = z
      blockArray[z][y][x] = new EmptyBlock

  
  THIS = this
  
  THIS.height = height
  THIS.depth = depth
  THIS.width = width
  THIS.player = player

  THIS.forEach = forEach
  THIS.forEachBlock = forEachBlock
  THIS.forEachBlockInLayer = forEachBlockInLayer
  THIS.blockAt = blockAt
  THIS.blockBelow = blockBelow

  return THIS
###
