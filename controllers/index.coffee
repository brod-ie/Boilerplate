module.exports.get = (req, res) ->
  res.render "index.jade",
  	version: req.version
  	title: "Brodie Boilerplate"