class LevelView
  constructor: ->
    @camera = new e3d.Camera
    @camera.distance = 12
    @camera.rotation = [0.5, 0, 0]
    
    @scene = new e3d.Scene
    @scene.camera = @camera
    
    imagefiles =
      'sky': ['/tex/sky.png']
      'level': ['/tex/wall.png', '/tex/floor.png', '/tex/platform.png']
      'box': ['/tex/box.png']
      'lift': ['/tex/lift.png', '/tex/lifttop.png']
      'player': ['/tex/player.png']
    
    instance = this
    loadImageFiles imagefiles, (images) ->
      SkyObject.setTextures(createTextures(images['sky']))
      StaticLevelObject.setTextures(createTextures(images['level']))
      BoxObject.setTextures(createTextures(images['box']))
      LiftObject.setTextures(createTextures(images['lift']))
      PlayerObject.setTextures(createTextures(images['player']))
      e3d.scene = instance.scene
    
    @currState = null
  
  update: (levelState) ->
    if levelState isnt @currState
      @currState = levelState
      
      center = [ levelState.width / 2
                 levelState.depth / 2
                 levelState.height / 2 ]
      
      @camera.position = center
      
      skySphere = new SkyObject
      skySphere.position = center
      
      levelModel = new StaticLevelObject(levelState)
      
      boxGroup = new e3d.Object
      boxGroup.children = levelState.forEach 'box',
                                             (box, position) ->
                                               new BoxObject(box)
      
      liftGroup = new e3d.Object
      liftGroup.children = levelState.forEach 'lift',
                                              (lift, x, y, z) ->
                                                new LiftObject(lift)
      
      @player = new PlayerObject(levelState.player)
      
      @scene.objects = [skySphere, levelModel, boxGroup, liftGroup, @player]
