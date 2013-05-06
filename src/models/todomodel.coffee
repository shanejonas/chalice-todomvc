{Model} = require 'backbone'

class TodoModel extends Model

  defaults:
    completed: false
    title: ''

  toggleStatus: ->
    @set 'completed',  not @get 'completed'

module.exports = TodoModel
