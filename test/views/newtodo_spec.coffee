NewTodo = require '../../src/views/newtodo'

describe 'NewTodo', ->

  it 'noops', ->
    NewTodo.should.be.a.function

  it 'has a template', ->
    view = new NewTodo
    view.template().should.include ''
