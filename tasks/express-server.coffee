#
# * grunt-express-server
# * https://github.com/ericclemmons/grunt-express-server
# *
# * Copyright (c) 2013 Eric Clemmons
# * Licensed under the MIT license.

#
path = require 'path'
server = null # Store server between live reloads to close/restart express
module.exports = (grunt) ->
  @registerTask 'express-keepalive', 'keep an express server alive', ->
    done = @async()

  @registerMultiTask 'express', 'Start an express web server', ->
    done = @async()
    config = grunt.config.get(@name)
    targetConfig = config[@target]
    if server
      console.log 'Killing existing Express server'
      server.kill 'SIGTERM'
      server = null

    server = grunt.util.spawn
      cmd: 'coffee'
      args: [targetConfig]
      fallback: ->
    # Prevent EADDRINUSE from breaking Grunt
    , (err, result, code) ->

    server.stdout.on 'data', ->
      done() if done
      done = null

    server.stdout.pipe process.stdout
    server.stderr.pipe process.stdout
