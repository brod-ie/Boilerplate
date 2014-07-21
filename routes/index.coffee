index = require("#{ __dirname }/../controllers/index")

module.exports = (app) ->
  app.get "/", index.get