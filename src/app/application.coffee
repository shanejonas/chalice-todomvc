Backbone = require 'backbone'
try Backbone.$ = require '$' catch e
_ = require 'underscore'
CompositeView = require 'chalice-compositeview'
Router = require 'chalice-client'
TodosListView = require '../views/todolistview.coffee'
TodosCollection = require '../collections/todoscollection.coffee'
NewTodoView = require '../views/newtodo.coffee'
StatsView = require '../views/statsview.coffee'

class Application extends Router

  fetcher: ->
    # default todos
    @todosCollection.reset [
        title: "Todo 1"
      ,
        title: "Todo 2"
    ]
    @trigger 'doneFetch'

  routes:
    '': 'index'

  index: ->
    @todosCollection = new TodosCollection
    compositeview = new CompositeView
    compositeview.addView new TodosListView collection: @todosCollection
    compositeview.addView new NewTodoView collection: @todosCollection
    compositeview.addView new StatsView collection: @todosCollection
    @swap compositeview
    @fetcher()

makeApplication = ->
  new Application

Backbone.$? ->
  makeApplication()
  Backbone.history.start pushState: yes

makeApplication() if not Backbone.$
