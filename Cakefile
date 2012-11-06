fs = require 'fs'
path = require 'path'
{exec} = require 'child_process'

source_dir = 'src'
target_dir = 'js'
target_name = 'zoko'

task 'build', 'build js file', ->
  command = 'coffee -c -b -o ' + target_dir + ' -j ' + target_name + '.coffee'
  files = readdir source_dir, '.coffee'
  for file in files
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
