LevelState = (levelData) ->

	blockArray =  for layer in levelData
		              for row in layer
                    for block in row
                      switch block
                        when 'O' then new SolidBlock()
                        when 'X' then new PlatformBlock()
                        else new EmptyBlock()
  
  @height = blockArray.length
  @depth = blockArray[0].length
  @width = blockArray[0][0].length
  
  @forEachBlock = (callback) ->
    for layer, z in blockArray
      for row, y in layer
        for block, x in row
          callback(block, x, y, z)
  
  @forEachBlockInLayer = (layer, callback) ->
    for row, y in blockArray[layer]
      for block, x in row
        callback(block, x, y)
  
  @blockAt = (x, y, z) ->
    if x < 0 or x >= @width then return new EmptyBlock
    if y < 0 or y >= @depth then return new EmptyBlock
    if z < 0 or z >= @height then return new EmptyBlock
    return blockArray[z][y][x]
  
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
