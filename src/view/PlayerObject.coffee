class PlayerObject extends e3d.Object
  playerMeshes = []
  playerTextures = []
  
  @setTextures = (textures) ->
    for texture, index in textures
      playerTextures[index] = texture
  
  constructor: (player) ->
    super()
    
    if playerMeshes.length is 0
      playerMeshes = [new e3d.Mesh(makeBox())]
    
    @meshes = playerMeshes
    @textures = playerTextures
    @position = player.position
