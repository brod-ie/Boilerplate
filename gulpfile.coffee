gulp = require "gulp"
util = require "gulp-util"
notify = require "gulp-notify"
_if = require "gulp-if"
browserSync = require("browser-sync").create()

__ = require "#{ __dirname }/lib/__"
reload = -> browserSync.reload()

# Paths
# =====
paths =
  root: "./public"
  scripts:
    dir: "./assets/scripts"
    dest: "./public/scripts"
    files: [
      "main"
    ]
  styles:
    src: "./assets/styles/*.scss"
    dest: "./public/styles"
  views:
    dir: "./views"
    src: "./views/*.jade"
    dest: "./public"
  tests:
    src: "./spec/*.coffee"

# Test
# ====
gulp.task "test", (callback) ->
  jasmine = require "gulp-jasmine"

  gulp.src paths.tests.src
    .pipe jasmine(
      verbose: true
    )

  callback(err) if err? # Exit if test's fail

# Scripts
# =======
gulp.task "scripts", ->
  coffeelint = require "gulp-coffeelint"
  reporter = require("coffeelint-stylish").reporter
  coffee = require "gulp-coffee"
  browserify = require "browserify"
  source = require "vinyl-source-stream"

  # Linting
  gulp.src "#{paths.scripts.dir}/*.litcoffee"
    .pipe do coffeelint
    .pipe do coffeelint.reporter
    .pipe coffeelint.reporter("fail")

  # Bundling client side scripts using Browserify
  options = {}
  options.debug = true if __.config().env is "develop"

  bundler = -> browserify(options)

  paths.scripts.files.forEach (file) ->
    mapLocation = "#{paths.scripts.dest}/maps/#{file}.map.json"
    publicMapLocation = "scripts/maps/#{file}.map.json"

    bundler()
      .add("#{paths.scripts.dir}/#{file}.litcoffee")
      .plugin("minifyify", {map: publicMapLocation, output: mapLocation})
      .bundle()
      .pipe(source "#{file}.js")
      .pipe(gulp.dest(paths.scripts.dest))
      .pipe( _if(process.platform is "darwin", notify("Built <%= file.relative %>")))

  # This was the server build step, needs reimplementing
  # ---------------------------------------------------------
  #
  # TODO: Use browserSync to run app.js instead of supervisor
  #
  # # Server
  # gulp.src paths.scripts.server.src
  #   .pipe do coffeelint
  #   .pipe do coffeelint.reporter
  #   .pipe do coffee
  #   .pipe gulp.dest paths.scripts.server.dest
  #   .pipe( _if(process.platform is "darwin", notify("Built <%= file.relative %>")))

# Styles
# ======
gulp.task "styles", ->
  sass = require "gulp-sass"
  autoprefixer = require "gulp-autoprefixer"
  minify_css = require "gulp-minify-css"
  replace = require "gulp-replace"
  css_import = require "gulp-cssimport"

  gulp.src paths.styles.src
    .pipe do sass
    .pipe do autoprefixer
    .pipe do css_import
    .pipe replace '/*!', '/*'
    .pipe do minify_css
    .pipe gulp.dest paths.styles.dest
    .pipe( _if(process.platform is "darwin", notify("Built <%= file.relative %>")))

# Views
# =====
gulp.task "views", ->
  jade = require "gulp-jade"

  # TODO:
  #
  #   When reimplementing the server create a second Jade system that
  #   writes .js templates and then uses:
  #
  #     define = require "gulp-define-module"
  #     .pipe define("node")
  #
  #   to modularise in CommonJS format

  gulp.src paths.views.src
    .pipe jade(
      locals:
        version: new Date().getTime()
      client: false
    )
    .pipe gulp.dest paths.views.dest
    .pipe( _if(process.platform is "darwin", notify("Built <%= file.relative %>")))

# Build
# =====
gulp.task "build", ["scripts", "styles", "views"], ->
  util.log "🔨  Built for #{__.config().env}"

# Default
# =======
gulp.task "default", ["build"], ->
  browserSync.init
    server:
      baseDir: paths.root

  util.log "👓  Watching..."
  gulp.watch(["#{paths.scripts.dir}/**/*.litcoffee", paths.tests.src], ["test", "scripts"]).on("change", reload)
  gulp.watch(paths.styles.src, ["styles"]).on("change", reload)
  gulp.watch(paths.views.src, ["views"]).on("change", reload)
