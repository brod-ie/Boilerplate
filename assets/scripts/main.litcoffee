# Global requires

Use Browserify with CommonJS modularisation to load external JavaScript
as if on a Node server

    $ = require "jquery"
    _ = require "lodash"
    Backbone = require "backbone"
    Backbone.$ = $

Fires on page load

    $ ->
      console.log "Hello World"
