class UI

  constructor: ->


  update: (game, args) ->
    switch args[0]
      when 'winner'
        # showWinnerModal()
        $('#next').on 'click', ->
          game.nextLevel()
      when 'steps'
        updateStepsCount()

  showWinnerModal: ->

  updateStepsCount: ->

