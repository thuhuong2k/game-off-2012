boxMeshes = []
boxTextures = []

setBoxTextures = (textures) ->
  for texture, index in textures
    boxTextures[index] = texture

BoxObject = (x, y, z) ->
  if boxMeshes.length is 0
    boxMeshes = [new e3d.Mesh(makeBox(0,0,0))]
  
  object = new e3d.Object
  object.meshes = boxMeshes
  object.textures = boxTextures
  object.position = [x, y, z]
  
  return object
