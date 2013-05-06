StatsView = require '../../src/views/statsview'
TodosCollection = require '../../src/collections/todoscollection'

describe 'StatsView', ->

  it 'noops', ->
    StatsView.should.be.a.function

  it 'has a template', ->
    view = new StatsView
    view.render().should.exist

  describe 'tasks completed', ->

    it 'displays tasks left', ->
      view = new StatsView
      view.render().should.include '0 tasks left'

    it 'displays number tasks completed when a collection is passed in', ->
      collection = new TodosCollection
      collection.reset [
          title: "Todo 1"
          completed: yes
        ,
          title: "Todo 2"
          completed: yes
      ]
      view = new StatsView
        collection: collection
      view.render().should.include 'Clear 2 completed task(s)'
