express = require 'express'
connect = require 'connect'
app = module.exports = express()

# TODO: only leave this in for development
# lrSnippet = require('grunt-contrib-livereload/lib/utils').livereloadSnippet

app.configure ->
  # TODO: only leave this in for development
  # app.use lrSnippet
  app.use connect.compress()
  app.use express.static __dirname + '/public'
  app.use (req, res, next)->
    res.setHeader('Content-Type', 'charset=utf-8')
    next()

require('chalice-server')(app, require './index.html.hbs')
require './src/app/application'

app.listen 3000
console.log 'listening on port 3000'
