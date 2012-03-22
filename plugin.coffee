
stylus = require 'stylus'
path = require 'path'
async = require 'async'
fs = require 'fs'

module.exports = (wintersmith, callback) ->

  class StylusPlugin extends wintersmith.ContentPlugin

    constructor: (@_filename, @_text) ->

    getFilename: ->
      @_filename.replace /styl$/, 'css'

    render: (locals, contents, templates, callback) ->
      try
        stylus.render @_text,
          filename: getFilename,
          (err, css) ->
            if err 
              throw err
            console.log css
      catch error
        callback error
      callback null, @_text

  StylusPlugin.fromFile = (filename, base, callback) ->
    fs.readFile path.join(base, filename), (error, buffer) ->
      if error
        callback error
      else
        callback null, new StylusPlugin filename, base, buffer.toString()

  wintersmith.registerContentPlugin 'styles', '**/*.styl', StylusPlugin
  callback()
