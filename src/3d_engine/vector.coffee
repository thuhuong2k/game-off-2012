
vec3 =
    vec4: ( v ) ->
        [ v[0]
          v[1]
          v[2]
          1    ]
    
    add: ( u, v ) ->
        [ u[0] + v[0]
          u[1] + v[1]
          u[2] + v[2] ]
    
    sub: ( u, v ) ->
        [ u[0] - v[0]
          u[1] - v[1]
          u[2] - v[2] ]
    
    mul: ( v, k ) ->
        [ v[0] * k
          v[1] * k
          v[2] * k ]
    
    div: ( v, k ) ->
        [ v[0] / k
          v[1] / k
          v[2] / k ]
    
    dot: ( u, v ) ->
        u[0] * v[0] + u[1] * v[1] + u[2] * v[2]
    
    len: ( v ) ->
        Math.sqrt( vec3.dot( v, v ) )
    
    unit: ( v ) ->
        vec3.div( v, vec3.len( v ) )


vec4 =
    add: ( u, v ) ->
        [ u[0] + v[0]
          u[1] + v[1]
          u[2] + v[2]
          u[3] + v[3] ]
    
    sub: ( u, v ) ->
        [ u[0] - v[0]
          u[1] - v[1]
          u[2] - v[2]
          u[3] - v[3] ]
    
    mul: ( v, k ) ->
        [ v[0] * k
          v[1] * k
          v[2] * k
          v[3] * k ]
    
    div: ( v, k ) ->
        [ v[0] / k
          v[1] / k
          v[2] / k
          v[3] / k ]
    
    dot: ( u, v ) ->
        u[0] * v[0] + u[1] * v[1] + u[2] * v[2] + u[3] * v[3]
    
    len: ( v ) ->
        Math.sqrt( vec4.dot( v, v ) )
    
    unit: ( v ) ->
        vec4.div( v, vec4.len( v ) )

