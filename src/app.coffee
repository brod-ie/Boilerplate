# Requires
require "coffee-script/register" # Needed for .coffee modules
require "longjohn" if process.env.NODE_ENV isnt "production"

express = require "express"

# Helper classes
__ = require "#{ __dirname }/../lib/__"
logger = require("tracer").colorConsole()

# Determine config
config = __.config()

app = express()
http = require("http").Server(app)
io = require("socket.io")(http)

# Express settings
app.engine "jade", require("jade").__express
app.set "view cache", true
app.set "views", "#{ __dirname }/../views"
app.use express.static("#{ __dirname }/../public")
app.use require("compression")()
app.use require("body-parser").json({ strict: false })
app.set 'json spaces', 2

# Middleware
app.use (req, res, next) ->
  # Hash?!
  req.version = require("crypto").randomBytes(20).toString("hex")
  next()

# Fix poorly formed JSON error
app.use (req, res, next) ->
  req.body = JSON.parse req.body if typeof req.body is "string"
  next()

# AUTHORISATION
# =============

# Bad access handler
unauthorized = (res) ->
  res.set "WWW-Authenticate", "Basic realm=Authorization Required"
  res.sendStatus 401

# Auth middleware for easy token validation
auth = (req, res, next) ->
  # if not req.query? or not req.query.token?
  #   return unauthorized res
  next()

# ERROR HANDLING
# ==============

# Error handler fn
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.json
    error: err.message

# Redirect to versioned endpoint
app.use (req, res, next) ->
  whole = req.path.indexOf "/v1.0"
  decimal = req.path.indexOf "/v1"
  api_req = req.path.indexOf "/api"

  if (whole is -1 and decimal is -1) and api_req isnt -1
    path = req.path.split("/api")
    path.push("/") if path.length is 0
    res.redirect "/api/v1.0#{ path[1] }"
  else
    next()

# Test data (For Loader.IO)
# =========================
# app.get "/test-data.json", (req, res) ->
#   res.json require "#{ __dirname }/../test-data.json"

# API
# ===
api = express.Router()

api.get "/", (req, res) ->
  res.json
    status: 200

app.use "/api/v1.0", api
app.use "/api/v1", api

# SPA (Single Page Application)
# =============================
spa = express.Router()

spa.get "/", (req, res) ->
  res.render "index.jade",
    version: req.version
    title: "Brodie's Boilerplate"

app.use "/", spa

# REAL TIME API
# =============

# Validate connection
io.use (socket, next) ->
  # (Template for token authorisation checking)
  # Parse URL
  # u = require("url").parse socket.handshake.url, true
  #
  # if not u.query? or not u.query.token?
  #   logger.warn "Bad Socket.IO connection attempt"
  #   return socket.disconnect()
  next()

io.on "connection", (socket) ->
  logger.info "Someone connected!"

  socket.on "disconnect", ->
    logger.info "Someone disconnected."

# Run server and return object
# ============================
server = http.listen config.PORT, ->
  logger.info "👂  Listening on port %d", server.address().port

return server # return for testing
