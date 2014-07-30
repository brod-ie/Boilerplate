require "coffee-script/register"

# Requires
express = require("express")
compress = require("compression")()

app = express()

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

server = app.listen 3000, ->
  console.log "👂  Listening on port %d", server.address().port