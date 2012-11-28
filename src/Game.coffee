class Game extends Observable

  # Pad a number with zeroes
  zeroExtend = (number, length) ->
    str = '' + number;
    while str.length < length
      str = '0' + str
    return str

  constructor: (@levelView) ->

    @currentLevel = 1
    @numLevels = 4
    @loadCurrentLevel()


  newGame: ->

  restartLevel: ->

  nextLevel: ->
    @currentLevel++
    if @currentLevel > @numLevels
      @currentLevel = 1

    @loadCurrentLevel()

  loadCurrentLevel: ->

    levelPath = 'levels/' + zeroExtend(@currentLevel, 2) + '.json'
    instance = this

    loadJsonFile levelPath, (level) ->
      levelState = new LevelState(level)
      levelState.onUpdate = ->
        instance.notifyObservers(levelState)

      levelState.observers = [instance.levelView]
      levelState.notifyObservers()

  # saveGame: ->
  # loadGame: ->