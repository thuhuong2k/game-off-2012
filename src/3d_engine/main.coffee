e3d = e3d || {}

e3d.init = (canvas) ->
  # Init WebGL
  gl = canvas.getContext('experimental-webgl', { alpha: false })

  # Set properties
  e3d.width = canvas.width
  e3d.height = canvas.height
  e3d.gl = gl
  e3d.scene = null
  e3d.program = e3d.compileProgram(e3d.vertexShaderSource, e3d.fragmentShaderSource)

e3d.run = ->
  # Setup rendering loop
  requestAnimationFrame = window.requestAnimationFrame ||
                          window.webkitRequestAnimationFrame ||
                          window.mozRequestAnimationFrame ||
                          window.oRequestAnimationFrame ||
                          window.msRequestAnimationFrame ||
                          (callback) -> window.setTimeout(callback, 1000/60)

  frame = ->
    requestAnimationFrame(frame)
    scene = e3d.scene
    if scene?
      scene.render()
      scene.update()

  # Start rendering loop
  requestAnimationFrame(frame)