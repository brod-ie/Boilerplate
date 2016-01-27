# Brodie's Boilerplate

A boilerplate implementing my tech stack of choice.

## Quick start

1. Fork this repo
2. `$ git clone https://github.com/your-username/Boilerplate.git`
3. `$ cd path/to/Boilerplate && npm run init && npm run build`

## Usage

### Initialise

    npm init

Installs all dependencies found in [`package.json`](https://github.com/ryanbrodie/Boilerplate/blob/master/package.json) as well as writing a default `config.json` file that sensitive statics can be defined outside of the repo.

### Developing

    gulp

Gulp will watch and build accordingly serving your assets using Browsersync.

### Build

    npm run build

Builds source using [Gulp](http://gulpjs.com/).

### Test

    npm run test

Performs tests using jasmine-node and Frisby.

### Run

    npm start

Runs the server using supervisor.

## Features

I've switched to a static boilerplate and will reimplement the dynamic Node server in the future.

For now, it has:

- GulpJS build system (with integrated Jasmine BDD testing)
- Jade templating
- Browserify for client side dependency
- ~~SocketIO~~ (to be reimplemented)
- Scripting in SASS & CoffeeScript
- Bootstrap, Backbone, Lodash, JQuery
- ~~Express server with static assets folder~~ (To be reimplemented)
- Cachebusting based on date
- Flat UI Colors and Animate.css for fron-tend niceties
- `config.json` system for project-wide configuration e.g. environment

## Todo
- Cachebuster based on cached git commit hash rather than datestamp
