resource_dir = 'res/'

loadImageFile = (filename, callback) ->
  image = new Image
  image.onload = -> callback(image)
  image.src = resource_dir + filename

loadJsonFile = (filename, callback) ->
  request = new XMLHttpRequest
  request.open('GET', resource_dir + filename, true)
  request.onreadystatechange = ->
    if request.readyState is 4 # Request finished and response is ready
      data = JSON.parse(request.responseText)
      callback(data)
  request.send()

loadFilesUsing = (loadFilesFunc, filenames, callback) ->
  if filenames instanceof Object is false
    filename = filenames
    loadFilesFunc filename, callback
  else
    if filenames instanceof Array
      nTotal = filenames.length
      loaded = []
    else
      nTotal = 0
      for own key of filenames then nTotal++
      loaded = {}
    nLoaded = 0
    for own key, entry of filenames
      do (key) ->
        loadFilesUsing loadFilesFunc, entry, (data) ->
          loaded[key] = data
          callback(loaded) if ++nLoaded is nTotal

loadImageFiles = (filenames, callback) ->
  loadFilesUsing loadImageFile, filenames, callback

loadJsonFiles = (filenames, callback) ->
  loadFilesUsing loadJsonFile, filenames, callback

loadResourceFiles = (filenames, callback) ->
  imagesLoaded = false
  jsonLoaded = false
  
  loaded = {}
  
  loadImageFiles filenames.images, (images) ->
    loaded.images = images
    imagesLoaded = true
    callback(loaded) if jsonLoaded
  
  loadJsonFiles filenames.json, (json) ->
    loaded.json = json
    jsonLoaded = true
    callback(loaded) if imagesLoaded
