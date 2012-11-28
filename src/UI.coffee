class UI

  constructor: ->
    @stepsCounter = $('#steps')
    @nextBtn = $('#nextBtn')
    @nextBtn.hide()
    @restartBtn = $('#restartBtn')

    instance = this

    @nextBtn.on 'click', ->
      instance.nextBtn.hide()
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
      @nextBtn.show()

    steps = levelState.steps
    @updateStepsCount(steps)

  showWinnerModal: ->

  updateStepsCount: (steps) ->
    @stepsCounter.html(steps + ' steps')

  resetStepsCount: ->
    @stepsCounter.html('0 steps')