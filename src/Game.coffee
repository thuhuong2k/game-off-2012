class Game

  constructor: ->
    loadJsonFile 'levels/01.json', (level) ->
      levelView = new LevelView()
      levelState = new LevelState(level)
      levelState.observers = [levelView]
      levelState.notifyObservers()
      new KeyboardController(levelState, levelView.camera)
      new MouseController(canvas, levelView.camera)