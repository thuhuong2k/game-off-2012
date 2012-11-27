class MouseController

  constructor: (canvas, camera) ->
    mouseDown = false
    previousX = 0
    previousY = 0
    sensitivity = 0.01

    $(canvas).on 'mousedown', (e) ->
      mouseDown = true
      previousX = e.screenX
      previousY = e.screenY
      console.log(e)

    $(document).on 'mouseup', (e) ->
      mouseDown = false
      console.log('mouse up')
    .on 'mousemove', (e) ->
      if mouseDown
        dx = (e.screenX - previousX) * sensitivity
        dy = (e.screenY - previousY) * sensitivity
        camera.rotate(dx, dy)
        previousX = e.screenX
        previousY = e.screenY
