TodoModel = require '../../src/models/todomodel'

describe 'TodoModel', ->

  it 'noops', ->
    TodoModel.should.be.a.function

  describe 'initialization', ->

    beforeEach ->
      @todo = new TodoModel

    it 'should default the status to "pending"', ->
      @todo.get('completed').should.be.false

    it 'should default the title to an empty string', ->
      @todo.get('title').should.equal ''

    it 'can toggle the status', ->
      @todo.get('completed').should.equal no
      @todo.toggleStatus()
      @todo.get('completed').should.equal yes

