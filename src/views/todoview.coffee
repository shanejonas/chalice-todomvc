View = require 'chalice-view'
template = require './todoview.hbs'

class TodoView extends View

  tagName: 'li'

  className: 'view view-todo'

  initialize: ->
    @listenTo @model, 'change', @render
    @listenTo @model, 'destroy', @remove

  template: template

  events:
    'change input[type=checkbox]': 'statusChanged'
    'dblclick label': 'edit'

  getTemplateData: ->
    @model.toJSON()

  edit: ->
    @$el.addClass 'editing'
    console.log 'editing'

  statusChanged: ->
    @model.toggleStatus()
    false

module.exports = TodoView
