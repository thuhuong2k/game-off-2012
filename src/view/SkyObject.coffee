skyMeshes = []
skyTextures = []

setSkyTextures = (textures) ->
  for texture, index in textures
    skyTextures[index] = texture

SkyObject = (x, y, z) ->
  if skyMeshes.length is 0
    skyMeshes[0] = null
    loadJson 'mod/sky.json', (sky) ->
      skyMeshes[0] = new e3d.Mesh(sky)
  
  object = new e3d.Object
  object.meshes = skyMeshes
  object.textures = skyTextures
  object.position = [x, y, z]
  object.scale = [80, 80, 80]
  
  return object
