fs = require 'fs'
# support handlebars extensions in node
handlebars = require 'handleify/node_modules/handlebars'

require.extensions['.hbs'] = (module, filename) ->
  template = handlebars.compile fs.readFileSync filename, 'utf8'
  module.exports = (context) ->
    template context

root.cheerio = require 'cheerio'
cheerio::off = ->
cheerio::on = ->
