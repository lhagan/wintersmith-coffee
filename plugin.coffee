CoffeeScript = require('coffee-script')
path         = require 'path'
async        = require 'async'
fs           = require 'fs'

module.exports = (wintersmith, callback) ->

  class CoffeePlugin extends wintersmith.ContentPlugin

    constructor: (@_filename, @_base, @_text) ->

    getFilename: ->
      @_filename.replace /coffee$/, 'js'

    render: (locals, contents, templates, callback) ->
      try
        js = CoffeeScript.compile()
        callback null, new Buffer js
      catch error
        callback error

  CoffeePlugin.fromFile = (filename, base, callback) ->
    fs.readFile path.join(base, filename), (error, buffer) ->
      if error
        callback error
      else
        callback null, new CoffeePlugin filename, base, buffer.toString()

  wintersmith.registerContentPlugin 'coffee', '**/*.coffee', CoffeePlugin
  callback()
