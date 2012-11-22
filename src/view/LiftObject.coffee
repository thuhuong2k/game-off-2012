liftMeshes = []
liftTextures = []

setLiftTextures = (textures) ->
  for texture, index in textures
    liftTextures[index] = texture

LiftObject = (lift) ->
  if liftMeshes.length is 0
    liftMeshes = [ new e3d.Mesh(makeLidlessBox())
                   new e3d.Mesh(makeTopFace()) ]
  
  object = new e3d.Object
  object.meshes = liftMeshes
  object.textures = liftTextures
  object.position = lift.position
  
  return object
