class Zoko

  constructor: (container) ->
    canvas = container.find('canvas')[0]
    console.log(canvas)
    e3d.init(canvas)
    levelView = new LevelView()
    new PlayerController(levelView)
    new CameraController(levelView, canvas)
    game = new Game(levelView)
    ui = new UI(container)
    game.observers = [ui]
    e3d.run()