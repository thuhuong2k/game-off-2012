class UI

  constructor: ->
    @stepsCounter = $('#steps')
    @nextBtn = $('#nextBtn')
    @menu = $('#menu')
    @menu.fadeOut()
    @menuOverlay = $('#menuOverlay')
    @menuOverlay.fadeOut()
    @restartBtn = $('#restartBtn')

    instance = this

    @nextBtn.on 'click', ->
      instance.menu.fadeOut()
      instance.menuOverlay.fadeOut()
      game = instance.game
      if game?
        game.nextLevel()
        instance.resetStepsCount()

    @restartBtn.on 'click', ->
      game = instance.game
      if game?
        game.restartLevel()
        instance.resetStepsCount()

  update: (game, args) ->
    @game = game
    levelState = args[0]
    if levelState.solved
      # showWinnerModal()
      @menuOverlay.fadeIn()
      @menu.fadeIn()

    steps = levelState.steps
    @updateStepsCount(steps)

  showWinnerModal: ->

  updateStepsCount: (steps) ->
    @stepsCounter.html(steps + ' steps')

  resetStepsCount: ->
    @stepsCounter.html('0 steps')