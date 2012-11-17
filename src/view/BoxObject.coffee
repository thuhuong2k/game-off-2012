boxMesh = null
boxTextures = []

setBoxTexture = (texture) ->
  boxTextures[0] = texture

BoxObject = (x, y, z) ->
  if boxMesh is null
    boxMesh = new e3d.Mesh(makeBox(0,0,0))
  
  object = new e3d.Object
  object.meshes = [boxMesh]
  object.textures = boxTextures
  object.position = [x, y, z]
  
  return object
