require "coffee-script/register"

# Requires
express = require "express"
compress = require("compression")()

app = express()
http = require("http").Server(app)
io = require("socket.io")(http)

# Express settings
app.engine "jade", require("jade").__express
app.set "view cache", true
app.set "views", "#{ __dirname }/../views"
app.use compress
app.use express.static(__dirname + "/../public")
app.locals.pretty = true

# Middleware
app.use (req, res, next) ->
  req.version = require("crypto").randomBytes(20).toString("hex")
  next()

require("#{ __dirname }/../routes")(app)

io.set 'transports', ['xhr-polling', 'jsonp-polling', 'polling']

io.on "connection", (socket) ->
  console.log "A user connected!"
  io.emit "message", { "message": "hello!", "id": socket.id }

io.on "auth", (data) ->
  console.log data

server = http.listen 3000, ->
  console.log "👂  Listening on port %d", server.address().port