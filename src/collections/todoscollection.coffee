{Collection} = require 'backbone'
TodosModel = require '../models/todomodel.coffee'

class TodosCollection extends Collection

  model: TodosModel

  # Filter down the list of all todo items that are finished.
  completed: ->
    @filter (todo) ->
      todo.get 'completed'

module.exports = TodosCollection
