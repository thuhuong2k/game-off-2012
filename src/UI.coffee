class UI

  constructor: (@game) ->
    @stepsCounter = $('#steps')
    @nextBtn = $('#nextBtn')
    @previousBtn = $('#previousBtn')
    @menu = $('#menu')
    @menu.hide()
    @menuTitle = @menu.find('.title')
    @menuOverlay = $('#menuOverlay')
    @menuOverlay.hide()
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

    @previousBtn.on 'click', ->
      instance.menu.fadeOut()
      instance.menuOverlay.fadeOut()
      instance.menuShown = false
      game = instance.game
      if game?
        game.previousLevel()
        instance.resetStepsCount()

    @restartBtn.on 'click', ->
      game = instance.game
      if game? and not instance.menuShown
        game.restartLevel()
        instance.resetStepsCount()

    @menuBtn.on 'click', ->
      if instance.menuShown
        instance.menu.fadeOut()
        instance.menuOverlay.fadeOut()
        instance.menuShown = false
      else
        instance.setMenuTitle('Options')
        instance.continueBtn.show()
        if instance.game.currentLevel+1 in instance.game.solvedLevels
          instance.nextBtn.show()
        else
          instance.nextBtn.hide()
        console.log "Hello!"
        console.log instance.game.solvedLevels
        if instance.game.currentLevel-1 in instance.game.solvedLevels
          console.log "Show previous"
          instance.previousBtn.show()
        else
          instance.previousBtn.hide()

        instance.menuOverlay.fadeIn()
        instance.menu.fadeIn()
        instance.menuShown = true


    @continueBtn.on 'click', ->
      instance.menu.fadeOut()
      instance.menuOverlay.fadeOut()
      instance.menuShown = false


  update: (game, args) ->
    @game = game
    levelState = args[0]
    if levelState.solved
      @game.solvedLevels.push(@game.currentLevel)
      @continueBtn.hide()
      @setMenuTitle('Good job!')
      @nextBtn.show()
      if @game.currentLevel-1 in @game.solvedLevels
        @previousBtn.show()
      else
        @previousBtn.hide()
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
