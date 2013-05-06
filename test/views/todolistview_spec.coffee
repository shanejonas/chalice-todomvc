TodoListView = require '../../src/views/todolistview'
TodosCollection = require '../../src/collections/todoscollection'
Backbone = require 'backbone'

describe 'TodoListView', ->

  it 'noops', ->
    TodoListView.should.be.a.function

  describe 'rendering on the client', ->

    before ->
      Backbone.$ = cheerio.load('<body></body>')
      @todos = new TodosCollection
      @list = new TodoListView collection: @todos
      @todos.reset [
          title: "Todo 1"
        ,
          title: "Todo 2"
      ]

    after ->
      Backbone.$ = null

    it "render() should return the view object", ->
      @list.render().should.equal @list

    it "should render as an unordered list", ->
      @list.tagName.should.equal 'ul'

    it "should include list items for all models in collection", ->
      @list.render()
      @list.$el.find("li").should.have.length 2
