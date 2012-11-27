class KeyboardController

  constructor: (levelState) ->

    $(document).on 'keydown', (e) ->
      switch e.which
        when 37 # left
          levelState.movePlayer('left')
        when 38 # up
          levelState.movePlayer('up')
        when 39 # right
          levelState.movePlayer('right')
        when 40 # down
          levelState.movePlayer('down')
