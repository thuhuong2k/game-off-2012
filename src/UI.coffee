class UI

  constructor: ->
    @stepsCounter = $('#steps')
    @nextBtn = $('#nextBtn')
    @nextBtn.hide()


  update: (game, args) ->
    switch args[0]
      when 'winner'
        console.log "Winner!"
        # showWinnerModal()
        @nextBtn.show()
        instance = this
        @nextBtn.on 'click', ->
          instance.nextBtn.hide()
          game.nextLevel()
      when 'steps'
        steps = game.getCurrentLevelState().steps
        updateStepsCount(steps)

  showWinnerModal: ->

  updateStepsCount: ->
    @stepsCounter.html(steps + 'steps')

