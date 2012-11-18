liftMeshes = []
liftTextures = []

setLiftTextures = (textures) ->
  for texture, index in textures
    liftTextures[index] = texture

LiftObject = (x, y, z) ->
  if liftMeshes.length is 0
    liftMeshes = [ new e3d.Mesh(makeLidlessBox(0,0,0))
                   new e3d.Mesh(makeTopFace(0,0,0)) ]
  
  object = new e3d.Object
  object.meshes = liftMeshes
  object.textures = liftTextures
  object.position = [x, y, z]
  
  return object
