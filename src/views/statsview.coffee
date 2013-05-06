_ = require 'underscore'
View = require 'chalice-view'
template = require './statsview.hbs'

class StatsView extends View

  className: 'view stats-view'

  template: template

  events:
    'click button': 'clearCompleted'

  initialize: ->
    if @collection?
      @listenTo @collection, 'change:completed', @render
      @listenTo @collection, 'all', @render

  getTemplateData: ->
    completed = @collection?.completed().length or 0
    completed: completed
    numLeft:  (@collection?.models.length or 0) - completed

  # Clear all completed todo items, destroying their models.
  clearCompleted: ->
    _(@collection.completed()).invoke 'destroy'

module.exports = StatsView
