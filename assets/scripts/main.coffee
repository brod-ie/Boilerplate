# Global requires
global.$ = require "jquery"
global._ = require "lodash"
global.Backbone = require "backbone"
global.Backbone.$ = $

# Bootstrap
require "bootstrap-browserify"

# Template(s)
window.jade = require "jade/runtime"
index = require "../../public/templates/index"

$(document).ready ->
