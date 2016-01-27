# Global requires

Use Browserify with CommonJS module formatting to load external JavaScript
as if on a Node server

    global.$ = require "jquery"
    global._ = require "lodash"
    global.Backbone = require "backbone"
    global.Backbone.$ = $

Fires on page load

    $ ->
      console.log "Hello World"
