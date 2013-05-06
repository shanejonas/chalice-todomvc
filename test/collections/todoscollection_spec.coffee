TodosCollection = require '../../src/collections/todoscollection'

describe 'TodosCollection', ->

  it 'noops', ->
    TodosCollection.should.be.a.function
