class BoxObject extends e3d.Object
  boxMeshes = []
  boxTextures = []
  
  @setTextures = (textures) ->
    for texture, index in textures
      boxTextures[index] = texture
  
  constructor: (box) ->
    super()
    
    if boxMeshes.length is 0
      boxMeshes = [new e3d.Mesh(makeBox())]
    
    @meshes = boxMeshes
    @textures = boxTextures
    @position = box.position
