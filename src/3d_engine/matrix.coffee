
mat =
    row: ( m, i ) ->
        [ m[i*4+0]
          m[i*4+1]
          m[i*4+2]
          m[i*4+3] ]
    
    col: ( m, i ) ->
        [ m[i+4*0]
          m[i+4*1]
          m[i+4*2]
          m[i+4*3] ]
    
    mul: ( a, b ) ->
        c0 = mat.col( a, 0 )
        c1 = mat.col( a, 1 )
        c2 = mat.col( a, 2 )
        c3 = mat.col( a, 3 )
        r0 = mat.row( b, 0 )
        r1 = mat.row( b, 1 )
        r2 = mat.row( b, 2 )
        r3 = mat.row( b, 3 )
        dot = vec4.dot
        
        [ dot( c0, r0 ), dot( c1, r0 ), dot( c2, r0 ), dot( c3, r0 )
          dot( c0, r1 ), dot( c1, r1 ), dot( c2, r1 ), dot( c3, r1 )
          dot( c0, r2 ), dot( c1, r2 ), dot( c2, r2 ), dot( c3, r2 )
          dot( c0, r3 ), dot( c1, r3 ), dot( c2, r3 ), dot( c3, r3 ) ]
    
    translate: ( m, v ) ->
        t = [ 1,    0,    0,    0
              0,    1,    0,    0
              0,    0,    1,    0
              v[0], v[1], v[2], 1 ]
        
        mat.mul( m, t )
    
    scale: ( m, v ) ->
        s = [ v[0], 0,    0,    0
              0,    v[1], 0,    0
              0,    0,    v[2], 0
              0,    0,    0,    1 ]
        
        mat.mul( m, s )
    
    rotateX: ( m, a ) ->
        s = Math.sin( a )
        c = Math.cos( a )
        r = [ 1, 0,  0, 0
              0, c, -s, 0
              0, s,  c, 0
              0, 0,  0, 1 ]
        
        mat.mul( m, r )
    
    rotateY: ( m, a ) ->
        s = Math.sin( a )
        c = Math.cos( a )
        r = [  c, 0, s, 0
               0, 1, 0, 0
              -s, 0, c, 0
               0, 0, 0, 1 ]
        
        mat.mul( m, r )
    
    rotateZ: ( m, a ) ->
        s = Math.sin( a )
        c = Math.cos( a )
        r = [ c, -s, 0, 0
              s,  c, 0, 0
              0,  0, 1, 0
              0,  0, 0, 1 ]
        
        mat.mul( m, r )
    
    identity: ->
        [ 1, 0, 0, 0
          0, 1, 0, 0
          0, 0, 1, 0
          0, 0, 0, 1 ]
    
    frustum: ( left, right, bottom, top, near, far ) ->
        a00 = ( near * 2 ) / ( right - left )
        a11 = ( near * 2 ) / ( top - bottom )
        a20 = ( right + left ) / ( right - left )
        a21 = ( top + bottom ) / ( top - bottom )
        a22 = -( far + near ) / ( far - near )
        a32 = -( far * near * 2 ) / ( far - near )
        
        [ a00, 0,   0,    0
          0,   a11, 0,    0
          a20, a21, a22, -1
          0,   0,   a32,  0 ]
    
    perspective: ( fovy, aspect, near, far ) ->
        top   = near * Math.tan( fovy * Math.PI / 360 )
        right = top * aspect
        
        mat.frustum( -right, right, -top, top, near, far )
    
    ortho: ( left, right, bottom, top, near, far ) ->
        a00 = 2 / ( right - left )
        a11 = 2 / ( top - bottom )
        a22 = 2 / ( far - near )
        a30 = -( left + right ) / ( right - left )
        a31 = -( top + bottom ) / ( top - bottom )
        a32 = -( far + near ) / ( far - near )
        
        [ a00, 0,   0,   0
          0,   a11, 0,   0
          0,   0,   a22, 0
          a30, a31, a32, 1 ]

