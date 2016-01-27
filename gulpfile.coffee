gulp = require "gulp"
util = require "gulp-util"
notify = require "gulp-notify"
_if = require "gulp-if"
browserSync = require("browser-sync").create()
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
    src: "./views/**/*.jade"
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
  uglify = require "gulp-uglify"
  browserify = require "browserify"
  source = require "vinyl-source-stream"

  gulp.src "#{paths.scripts.dir}/*.litcoffee"
    .pipe do coffeelint
    .pipe do coffeelint.reporter
    .pipe coffeelint.reporter("fail")

  paths.scripts.files.forEach (file) ->
    browserify("#{paths.scripts.dir}/#{file}.litcoffee")
      .bundle()
      .pipe(source "#{file}.js")
      .pipe(gulp.dest(paths.scripts.dest))
      .pipe( _if(process.platform is "darwin", notify("Built <%= file.relative %>")))

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
  util.log "🔨  Built"

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
