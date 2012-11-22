boxMeshes = []
boxTextures = []

setBoxTextures = (textures) ->
  for texture, index in textures
    boxTextures[index] = texture

BoxObject = (box) ->
  if boxMeshes.length is 0
    boxMeshes = [new e3d.Mesh(makeBox())]
  
  object = new e3d.Object
  object.meshes = boxMeshes
  object.textures = boxTextures
  object.position = box.position
  
  return object
