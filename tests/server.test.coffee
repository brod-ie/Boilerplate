config = require "#{ __dirname }/../../Boilerplate.json"

describe 'Database', ->
  it 'can connect to GrapheneDb', ->
    neo4j = require "neo4j"
    db = new neo4j.GraphDatabase config.neo4j

describe 'Server', ->
  it 'can tell 5 is 5', ->
    expect(5).toBe 5