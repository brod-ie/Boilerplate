# Global requires
window.$ = require "jquery"
window._ = require "lodash"
window.Backbone = require "backbone"
window.Backbone.$ = $

# Template(s)
window.jade = require "jade/runtime"
index = require "../../public/templates/index"

$(document).ready ->
  $("p").addClass "animated pulse"