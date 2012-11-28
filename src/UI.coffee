class UI

  constructor: ->
    @stepsCounter = $('#steps')
    @nextBtn = $('#nextBtn')
    @menu = $('#menu')
    @menu.fadeOut()
    @menuTitle = @menu.find('.title')
    @menuOverlay = $('#menuOverlay')
    @menuOverlay.fadeOut()
    @menuShown = false
    @continueBtn = $('#continueBtn')
    @continueBtn.hide()

    @restartBtn = $('#restartBtn')
    @menuBtn = $('#menuBtn')

    instance = this

    @nextBtn.on 'click', ->
      instance.menu.fadeOut()
      instance.menuOverlay.fadeOut()
      instance.menuShown = false
      game = instance.game
      if game?
        game.nextLevel()
        instance.resetStepsCount()

    @restartBtn.on 'click', ->
      game = instance.game
      if game? and not instance.menuShown
        game.restartLevel()
        instance.resetStepsCount()

    @menuBtn.on 'click', ->
      instance.setMenuTitle('Options')
      instance.menuOverlay.fadeIn()
      instance.menu.fadeIn()
      instance.menuShown = true
      instance.continueBtn.show()

    @continueBtn.on 'click', ->
      instance.menu.fadeOut()
      instance.menuOverlay.fadeOut()
      instance.menuShown = false


  update: (game, args) ->
    @game = game
    levelState = args[0]
    if levelState.solved
      @continueBtn.hide()
      @setMenuTitle('Good job!')
      @menuOverlay.fadeIn()
      @menu.fadeIn()
      @menuShown = true

    steps = levelState.steps
    @updateStepsCount(steps)

  showWinnerModal: ->

  updateStepsCount: (steps) ->
    @stepsCounter.html(steps + ' steps')

  resetStepsCount: ->
    @stepsCounter.html('0 steps')

  setMenuTitle: (title) ->
    @menuTitle.html(title)
