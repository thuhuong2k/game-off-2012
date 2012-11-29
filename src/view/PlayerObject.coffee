class PlayerObject extends e3d.Object
  playerMeshes = []
  playerTextures = []
  
  @setTextures = (textures) ->
    for texture, index in textures
      playerTextures[index] = texture
  
  constructor: (@player) ->
    super()
    
    if playerMeshes.length is 0
      playerMeshes[0] = null
      loadJsonFile 'models/player.json', (player) ->
        playerMeshes[0] = new e3d.Mesh(player)
    
    @meshes = playerMeshes
    @textures = playerTextures
    @scale = [0.5, 0.5, 0.5]
  
  render: (matrix) ->
    @position = vec.add(@player.position, [0.5, 0.5, 0.5])
    
    direction = @player.direction
    halfPI = Math.PI / 2
    if vec.equal(direction, [ 0, 1, 0]) then @rotation = [0, 0, 0 * halfPI]
    if vec.equal(direction, [-1, 0, 0]) then @rotation = [0, 0, 1 * halfPI]
    if vec.equal(direction, [ 0,-1, 0]) then @rotation = [0, 0, 2 * halfPI]
    if vec.equal(direction, [ 1, 0, 0]) then @rotation = [0, 0, 3 * halfPI]
    
    super(matrix)
