# Requires
__ = require "#{ __dirname }/../lib/__"
frisby = require "frisby"
io = require "socket.io-client"
AsyncSpec = require "node-jasmine-async"

# Determine config
config = __.config()
server = require "#{ __dirname }/../app/app" # Server on localhost:5000

describe "Web server", ->

  # REST API
  # ========
  frisby
    .create "Site homepage can be reached"
    .get "http://localhost:#{ config.PORT }"
    .expectStatus 200
    .toss()

  frisby
    .create "Web server can return an error for bad endpoints"
    .get "http://localhost:#{ config.PORT }/jksjckjks"
    .expectStatus 404
    .toss()

  # REAL TIME API
  # =============

  # # setup
  # async = new AsyncSpec(this)
  # client = null
  #
  # # connect to Socket.IO server
  # # ---------------------------
  # async.beforeEach (done) ->
  #   client = io.connect "http://localhost:#{ config.PORT }?token=#{ token }"
  #   done()
  #
  # # determine output is correct
  # # ---------------------------
  # async.it "recieved new message event", (done) ->
  #   client.on "message", (message) ->
  #     expect(message.message).toBe "Hello world!"
  #   done()
  #
  # async.it "recieved users/active event", (done) ->
  #   client.on "users/active", (users) ->
  #     expect(users).toBe(jasmine.any(Object))
  #   done()
  #
  # # FINISH
  # # ======
  #
  # # Timeout server now complete
  # afterEach (done) ->
  #   setTimeout ->
  #     # Disconnect Socket.IO first
  #     client.disconnect()
  #     # Then close server
  #     setTimeout ->
  #       server.close()
  #     , 1000
  #   , 500
  #   done()
