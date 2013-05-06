TodoView = require '../../src/views/todoview'
TodoModel = require '../../src/models/todomodel'
Backbone = require 'backbone'

describe 'TodoView', ->

  it 'noops', ->
    TodoView.should.be.a.function

  describe 'rendering on the server', ->

    before ->
      @todo = new TodoModel(title: "Summary")
      @item = new TodoView
        model: @todo

    it "should have a title", ->
      @item.render().should.include @todo.get('title')

    it 'should include a label for the status', ->
      @item.render().should.include 'label'

    it 'should include an <input> checkbox', ->
      @item.render().should.include 'input'

  describe 'rendering on the client', ->

    before ->
      Backbone.$ = cheerio.load('<body></body>')
      @item = new TodoView
        model: @todo

    after ->
      Backbone.$ = null

    it "render() should return the view object", ->
      @item.render().should.equal @item

    it "should render as a list item", ->
      @item.tagName.should.equal 'li'
