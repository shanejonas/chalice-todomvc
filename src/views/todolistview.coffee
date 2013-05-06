CompositeView = require 'chalice-compositeview'
TodoView = require './todoview.coffee'
Backbone = require 'backbone'

class TodoListView extends CompositeView

  tagName: 'ul'

  initialize: ->
    # @firstRender = yes
    @listenTo @collection, 'add', @addOne
    @listenTo @collection, 'reset', @addAll
    # @listenTo @collection, 'change:completed', @filterOne
    # @listenTo @collection, 'filter', @filterAll
    # @listenTo @collection, 'all', @render

  # Add a single todo item to the list by creating a view for it, and
  # appending its element the list element. You can not have it append by
  # passing false to the insert param.
  addOne: (todo, insert=yes) ->
    view = new TodoView
      model: todo
    @views.push view
    if insert
      @$el?.append view.render().el

  # Add all items in the collection at once.
  addAll: ->
    # teardown views
    if @views?.length > 0 then @removeView view for view in @views
    @views = []
    # add new views back one by one, but dont repaint
    @addOne model, no for model in @collection.models
    # if not @firstRender
    #   @firstRender = no
    #   @render()

  # filterOne: (todo) ->
  #   todo.trigger "visible"

  # filterAll: ->
  #   app.Todos.each @filterOne, this

  # toggleAllComplete: ->
  #   completed = @allCheckbox.checked
  #   app.Todos.each (todo) ->
  #     todo.save completed: completed

module.exports = TodoListView
