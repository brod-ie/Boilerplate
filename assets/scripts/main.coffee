window.$ = require "jquery"
window._ = require "lodash"
window.Backbone = require "backbone"
window.Backbone.$ = $
window.jade = require "jade/runtime"

index = require "../../public/templates/index"

class Router extends Backbone.Router
  routes:
    'ryan/:surname':   'fullName'
  fullName: (surname) ->
    console.log surname

$(document).ready ->

  App = {}
  App.router = new Router()

  Backbone.history.start
    pushState: true

  $(document).on "click", "a[href^='/']", (event) ->

    href = $(event.currentTarget).attr('href')

    # chain 'or's for other black list routes
    passThrough = false # href.indexOf('sign_out') >= 0
    press = !event.altKey && !event.ctrlKey && !event.metaKey && !event.shiftKey

    # Allow shift+click for new tabs, etc.
    if window.history and history.pushState and not passThrough and press
      event.preventDefault()

      # Remove leading slashes and hash bangs (backward compatablility)
      url = href.replace(/^\//,'').replace('\#\!\/','')

      # Instruct Backbone to trigger routing events
      App.router.navigate url, { trigger: true }

      return false