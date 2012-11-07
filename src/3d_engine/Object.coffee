e3d = e3d || {}

# 3D object constructor
e3d.Object = ->
  gl = e3d.gl
  program = e3d.program.mesh
  
  @position = [0,0,0]
  @rotation = [0,0,0]
  @scale = [1,1,1]
  
  @meshes = []
  @textures = []
  
  @children = []
  
  @render = (matrix) ->
    matrix = mat.translate(matrix, @position)
    matrix = mat.rotateX(matrix, @rotation[0])
    matrix = mat.rotateY(matrix, @rotation[1])
    matrix = mat.rotateZ(matrix, @rotation[2])
    matrix = mat.scale(matrix, @scale)
    
    program.setMatrix(matrix)
    
    e3d.noTexture.use()
    for mesh, i in @meshes
      if mesh?
        if @textures[i]?
          @textures[i].use()
        mesh.render()
    
    for child in @children
      if child?
        child.render(matrix)
  
  return
