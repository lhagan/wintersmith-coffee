
stylus = require 'stylus'
path = require 'path'
async = require 'async'
fs = require 'fs'

module.exports = (wintersmith, callback) ->

  class StylusPlugin extends wintersmith.ContentPlugin

    constructor: (@_filename, @_base, @_text) ->

    getFilename: ->
      @_filename.replace /styl$/, 'css'

    render: (locals, contents, templates, callback) ->
      try
        that = this
        options = 
          filename: this.getFilename()
          path: @_base
        stylus(@_text).set('filename', this.getFilename()).render callback
          stream = fs.createWriteStream path.join(options['path'], options['filename'])
          stream.once 'open', (fd) ->
            stream.write css
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
