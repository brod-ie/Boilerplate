# Brodie Boilerplate

A boilerplate implementing my tech stack of choice.

## Quick start

1. Fork this repo
2. `$ git clone https://github.com/your-username/Boilerplate.git`
3. `$ cd path/to/Boilerplate && npm run init && npm run build`

## Running the server

1. `$ npm start`
2. Navigate to [`http://localhost:3000`](http://localhost:3000)

## Features

- GulpJS build system (with integrated Jasmine BDD testing)
- Jade templating
- Browserify for client side dependency
- SocketIO
- Scripting in SASS & CoffeeScript
- Bootstrap, Backbone, Lodash, JQuery
- Express server with static assets folder
- Cachebusting based on date
- Flat UI Colors and Animate.css for frontend niceties

## Todo
- Cachebuster based on cached git commit hash rather than datestamp
- Proper environment switching
  - local, dev, and production
  - Use `process.env.ENV_VARIABLE` to establish debugging and minify practices
- ~~Shared views between client/server~~
- Backbone history using pushstate
- ~~SocketIO~~
- Neo4j
- ~~Lodash + Backbone~~
- Finish Hello.coffee notification class
- ~~Testing with [Jasmine](http://coffeescriptcookbook.com/chapters/testing/testing_with_jasmine)~~
- ASync browserify module loading
  - Use jQuery only for legacy browsers and Zepto where possible
  - Download templates on the fly
