# Global requires
window.$ = require "jquery"
window._ = require "lodash"
window.Backbone = require "backbone"
window.Backbone.$ = $

# Bootstrap
require "bootstrap-browserify"

# Template(s)
window.jade = require "jade/runtime"
index = require "../../public/templates/index"

# Libs
window.Hello = require "../../lib/hello.coffee"

$(document).ready ->
  # Socket.IO
  socket = io()

  # Connection handlers
  socket.on "connect", ->
    Hello.vanish().success "Connected!"

  socket.on "connect_timeout", ->
    Hello.vanish().warn "Connection timeout"

  socket.on "connect_error", (err) ->
    Hello.vanish().fatal "Couldn't connect to server."

  socket.on "reconnect_attempt", ->
    Hello.vanish().warn "Attempting to reconnect"

  socket.on "reconnecting", ->
    Hello.vanish().warn "Attempting to reconnect"

  socket.on "reconnect_failed", ->
    Hello.vanish().fatal "Failed to reconnect"

  # Message handlers
  socket.on "message", (message) ->
    console.log message