fs = require 'fs'
path = require 'path'
{exec} = require 'child_process'

source_dir = 'src'
target_dir = 'js'
target_name = 'zoko'

required_order = [
  source_dir + '/Observable.coffee'
]

task 'build', 'build js file', ->
  command = 'coffee -c -b -o ' + target_dir + ' -j ' + target_name + '.coffee'
  
  # Files required to be in a specific order comes first
  for file in required_order
    command += ' ' + file
  
  # Then the rest of the files
  files = readdir source_dir, '.coffee'
  for file in files
    if required_order.indexOf file is -1
      command += ' ' + file
  
  exec command, ( err, stdout, stderr ) ->
    throw err if err
    console.log 'Done!'

# Recursive, synchronous readdir
readdir = ( dir, ext ) ->
  filelist = []
  files = fs.readdirSync dir
  for file in files
    file = dir + '/' + file
    stats = fs.statSync file
    if stats.isDirectory()
      filelist = filelist.concat readdir file, ext
    else if path.extname( file ) is ext
      filelist.push file
  return filelist
