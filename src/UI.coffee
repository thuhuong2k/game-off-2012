class UI

  constructor: ->
    @stepsCounter = $('#steps')
    @nextBtn = $('#nextBtn')
    @nextBtn.hide()
    instance = this
    @nextBtn.on 'click', ->
      instance.nextBtn.hide()
      game = instance.game
      game.nextLevel() if game?

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

