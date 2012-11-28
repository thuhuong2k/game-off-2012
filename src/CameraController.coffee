class CameraController

  constructor: (levelView, canvas) ->
    camera = levelView.camera
    mouseDown = false
    previousX = 0
    previousY = 0
    sensitivity = 0.01

    $(canvas).on 'mousedown', (e) ->
      mouseDown = true
      previousX = e.screenX
      previousY = e.screenY

    $(document).on 'mouseup', (e) ->
      mouseDown = false
    .on 'mousemove', (e) ->
      if mouseDown
        dx = (e.screenX - previousX) * sensitivity
        dy = (e.screenY - previousY) * sensitivity
        camera.rotate(dx, dy)
        previousX = e.screenX
        previousY = e.screenY
