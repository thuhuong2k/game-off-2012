class UI

  constructor: ->
    @stepsCounter = $('#steps')
    @nextBtn = $('#nextBtn')
    @nextBtn.hide()


  update: (game, args) ->
    levelState = args[0]
    if levelState.solved
      # showWinnerModal()
      @nextBtn.show()
      instance = this
      @nextBtn.on 'click', ->
        instance.nextBtn.hide()
        game.nextLevel()

    steps = levelState.steps
    @updateStepsCount(steps)

  showWinnerModal: ->

  updateStepsCount: (steps) ->
    @stepsCounter.html(steps + ' steps')

