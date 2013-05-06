View = require 'chalice-view'
template = require './newtodo.hbs'
ENTER_KEY = 13

class NewTodo extends View

  tagName: 'input'

  className: 'view view-todo-new'

  events:
    'keyup': 'createOnEnter'

  template: -> ''

  # Generate the attributes for a new Todo item.
  newAttributes: ->
    title: @$el.val().trim()
    completed: false

  # If you hit return in the main input field, create new **Todo** model
  createOnEnter: (e) ->
    return  if e.which isnt ENTER_KEY or not @$el.val().trim()
    # @collection.create @newAttributes()
    @collection.add @newAttributes()
    @$el.val ""

module.exports = NewTodo
