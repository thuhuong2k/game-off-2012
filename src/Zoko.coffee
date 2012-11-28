class Zoko

  constructor: (canvas) ->
    e3d.init(canvas)
    levelView = new LevelView()
    new PlayerController(levelView)
    new CameraController(levelView, canvas)
    @game = new Game(levelView)
    e3d.run()