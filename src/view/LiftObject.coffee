class LiftObject extends e3d.Object
  liftMeshes = []
  liftTextures = []
  
  @setTextures = (textures) ->
    for texture, index in textures
      liftTextures[index] = texture
  
  constructor: (lift) ->
    super()
    
    if liftMeshes.length is 0
      liftMeshes = [ new e3d.Mesh(makeLidlessBox())
                     new e3d.Mesh(makeTopFace()) ]
    
    @meshes = liftMeshes
    @textures = liftTextures
    @position = lift.position
