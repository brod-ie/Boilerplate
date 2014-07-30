gulp = require "gulp"
util = require "gulp-util"

# Paths
# =====
paths =
  scripts:
    server:
      src: "./src/*.coffee"
      dest: "./app"
    client:
      src: "./assets/scripts/main.coffee"
      dest: "./public/scripts"
  styles:
    src: "./assets/styles/*.scss"
    dest: "./public/styles"
  views:
    src: "./views/*.jade"
    dest: "./public/templates"

# Scripts
# =======
gulp.task "scripts", ->
  coffeelint = require "gulp-coffeelint"
  reporter = require("coffeelint-stylish").reporter
  coffee = require "gulp-coffee"
  uglify = require "gulp-uglify"
  browserify = require "browserify"
  source = require "vinyl-source-stream"

  # Client
  gulp.src paths.scripts.client.src
    .pipe do coffeelint
    .pipe do coffeelint.reporter
    .pipe coffeelint.reporter("fail")

  browserify( paths.scripts.client.src )
    .bundle()
    .pipe(source 'main.js')
    .pipe(gulp.dest( paths.scripts.client.dest ));

  # Server
  gulp.src paths.scripts.server.src
    .pipe do coffeelint
    .pipe do coffeelint.reporter
    .pipe do coffee
    .pipe gulp.dest paths.scripts.server.dest

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

# Views
# =====
gulp.task "views", ->
  jade = require "gulp-jade"
  define = require "gulp-define-module"

  gulp.src paths.views.src
    .pipe jade(
      client: true
    )
    .pipe define("node")
    .pipe gulp.dest paths.views.dest

# Build
# =====
gulp.task "build", ["scripts", "styles", "views"], ->
  util.log "🔨  Built"

# Default
# =======
gulp.task "default", ["build"], ->
  util.log "👓  Watching..."
  gulp.watch [paths.scripts.server.src, paths.scripts.client.src], ["scripts"]
  gulp.watch paths.styles.src, ["styles"]
  gulp.watch paths.views.src, ["views"]
