CoffeeScript = require('coffee-script')
path         = require 'path'
async        = require 'async'
fs           = require 'fs'

module.exports = (env, callback) ->

  class CoffeePlugin extends env.ContentPlugin

    constructor: (@_filepath, @_text) ->

    getFilename: ->
      @_filepath.relative.replace /coffee$/, 'js'
    
    getView: ->
      return (env, locals, contents, templates, callback) ->
        try
          js = CoffeeScript.compile(@_text)
          callback null, new Buffer js
        catch error
          callback error

  CoffeePlugin.fromFile = (filepath, callback) ->
    fs.readFile filepath.full, (error, buffer) ->
      if error
        callback error
      else
        callback null, new CoffeePlugin filepath, buffer.toString()

  env.registerContentPlugin 'coffee', '**/*.coffee', CoffeePlugin
  callback()
