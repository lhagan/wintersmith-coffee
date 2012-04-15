wintersmith  = require('wintersmith')
wsCoffee     = require('./../')

describe "CoffeeScript integration", ->

  beforeEach (done)->

    # Install this plugin onto wintersmith
    wsCoffee wintersmith, ->

      # Installed, now wintersmith can handle .coffee
      done()

  it "should compile coffeescript", (done)->

    # Parse contents
    wintersmith.ContentTree.fromDirectory 'test/contents/js', __dirname, (err, tree)->
      # For main.styl, we want to make sure coffee is compiled
      tree['main.coffee'].render null, null, null, (err, content)->
        
        if content?
          content.should.equal("""
            (function() {
              var a;

              a = 1 + 1;

            }).call(this);""")
          # yay
        done()


  it "should treat coffeescript error", (done)->

    # Parse contents
    wintersmith.ContentTree.fromDirectory 'test/contents/js', __dirname, (err, tree)->

      # For fail.coffee, it should return err
      tree['fail.coffee'].render null, null, null, (err, content)->
        if err?
          done()
