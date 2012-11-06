e3d = e3d || {}

e3d.vertexShaderSource = """
  uniform mat4 uMatrix;
  attribute vec3 aPosition;
  attribute vec2 aTexCoord;
  attribute vec3 aColor;
  varying vec2 vTexCoord;
  varying vec3 vColor;
  
  void main() {

    gl_Position = uMatrix * vec4(aPosition,1);
    vTexCoord = aTexCoord;
    vColor = aColor;

  }
"""

e3d.fragmentShaderSource = """
  precision mediump float;

  uniform sampler2D uTexture;
  varying vec2 vTexCoord;
  varying vec3 vColor;

  void main() {

    gl_FragColor = texture2D(uTexture, vTexCoord) * vec4(vColor,1);

  }
"""

e3d.compileProgram = (vertexSource, fragmentSource) ->

  gl = e3d.gl

  createShader = (type,source) ->
    id = gl.createShader(type)
    gl.shaderSource(id,source)
    gl.compileShader(id)
    if not gl.getShaderParameter(id, gl.COMPILE_STATUS)
      console.log gl.getShaderInfoLog(id)
      throw "compileShader fail!"
    return id

  program = gl.createProgram()
  gl.attachShader(program, createShader(gl.VERTEX_SHADER, vertexSource))
  gl.attachShader(program, createShader(gl.FRAGMENT_SHADER, fragmentSource))
  gl.linkProgram(program)
  if not gl.getProgramParameter(program, gl.LINK_STATUS)
    console.log gl.getProgramInfoLog(program)
    throw "linkProgram fail!"

  return program
