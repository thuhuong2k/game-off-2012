class UI

  constructor: ->


  update: (game, args) ->
    switch args[0]
      when 'winner'
        showWinnerModal()
      when 'steps'
        updateStepsCount()

  showWinnerModal: ->

  updateStepsCount: ->

