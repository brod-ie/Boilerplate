# Notification class

class Hello

  constructor: ->
    @style = ""
    @type = "vanish"

  # Types
  sticky: ->
    @type = "sticky"
    this

  modal: ->
    @type = "modal"
    this

  vanish: ->
    @type = "vanish"
    this

  # Styles
  success: (message) ->
    @style = "success"
    @show message
    console.log message
    
  error: (message) ->
    @style = "error"
    @show message
    console.warn message

  fatal: (message) ->
    @style = "fatal"
    @show message
    console.warn message

  info: (message) ->
    @style = "info"
    @show message
    console.log info

  show: (message) ->
    # Animate in notification
    $elem = $("<div/>")
      .addClass("hello #{ @style }")
      .prepend("<div class=\"container\"><p>#{ message }</p><p></p></div>")
      .prependTo("body")
      .show()
      .addClass("slideDown")

    @_vanish($elem) if @type is "vanish"
    @_sticky($elem) if @type is "sticky"

  _sticky: ($elem) ->
    $("div p:last-child", $elem)
      .html("&times;")

  _modal: (message) ->

  _vanish: ($elem) ->
    setTimeout ->
      $elem
        .removeClass('slideDown')
        .addClass('slideUp')
        setTimeout ->
          $elem.remove()
        , 300
    , 3000

module.exports = new Hello