resource_dir = 'res/'

loadImage = (filename, callback) ->
  image = new Image
  image.onload = -> callback(image)
  image.src = resource_dir + filename

loadJson = (filename, callback) ->
  request = new XMLHttpRequest
  request.open('GET', resource_dir + filename, true)
  request.onreadystatechange = ->
    if request.readyState is 4 # Request finished and response is ready
      object = JSON.parse(request.responseText)
      callback(object)
  request.send()
