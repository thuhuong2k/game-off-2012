playerMeshes = []
playerTextures = []

setPlayerTextures = (textures) ->
  for texture, index in textures
    playerTextures[index] = texture

PlayerObject = (player) ->
  if playerMeshes.length is 0
    playerMeshes = [new e3d.Mesh(makeBox(0,0,0))]

  object = new e3d.Object
  object.meshes = playerMeshes
  object.textures = playerTextures
  object.position = player.position

  return object
