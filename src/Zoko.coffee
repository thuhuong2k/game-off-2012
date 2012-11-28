class Zoko

  constructor: (canvas) ->
    e3d.init(canvas)
    new Game
    e3d.run()