e3d = e3d || {}

# 3D scene constructor
e3d.Scene = ->
  gl = e3d.gl
  program = e3d.program.mesh
  
  @objects = []
  @camera = null

  @render = ->
    if @camera?
      program.begin()
      matrix = @camera.createMatrix()
      for object in @objects
        if object?
          object.render(matrix)
      program.end()

  return
