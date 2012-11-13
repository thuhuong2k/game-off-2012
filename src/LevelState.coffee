LevelState = (levelData) ->

	@blockArray = for layer in levelData
		              for row in layer
                    for block in row
                      switch block
                        when 'O' then new SolidBlock()
                        when 'X' then new PlatformBlock()
                        else new EmptyBlock()

  return

EmptyBlock = ->

  @empty = true

  return

SolidBlock = ->

  @empty = false

  return

PlatformBlock = ->

  @empty = false

  return
