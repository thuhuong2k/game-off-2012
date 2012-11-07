e3d = e3d || {}

# 3D mesh constructor
e3d.Mesh = (data) ->
  gl = e3d.gl
  program = e3d.program.mesh
  
  vertexbuffer = gl.createBuffer()
  gl.bindBuffer(gl.ARRAY_BUFFER, vertexbuffer)
  
  gl.vertexAttribPointer(program.aPositionLoc, 3, gl.FLOAT, false, 32, 0)
  gl.vertexAttribPointer(program.aTexCoordLoc, 2, gl.FLOAT, false, 32, 12)
  gl.vertexAttribPointer(program.aColorLoc, 3, gl.FLOAT, false, 32, 20)
  
  gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(data), gl.STATIC_DRAW)
  
  nvertices = data.length / 8
  
  @render = ->
    gl.bindBuffer(gl.ARRAY_BUFFER, vertexbuffer)
    gl.drawArrays(gl.TRIANGLES, 0, nvertices)
  
  return
