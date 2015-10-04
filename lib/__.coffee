# Helper class
class __

  config: ->
    return process.env if process.env.ENVIRONMENT?
    return require "#{ __dirname }/../config.json"

module.exports = new __
