e3d = e3d || {}

e3d.Scene = ->

  gl = e3d.gl
  
  @objects = []
  
  @camera = null

  @render = ->
    gl.clear(gl.COLOR_BUFFER_BIT)

    for object in @objects
      if object?
        object.render()

  @update = ->
    for object in @objects
      if object?
        object.update()

  return
