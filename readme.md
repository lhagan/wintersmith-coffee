# wintersmith-coffee

[CoffeeScript](http://coffeescript.org/) plugin for [wintersmith](https://github.com/jnordberg/wintersmith).

### install:

    npm install wintersmith-coffee
  
then add `./node_modules/wintersmith-coffee/` to `config.json` like:

    {
      "locals": {
        "url": "http://localhost:8080",
        "name": "The Wintersmith's blog",
        "owner": "The Wintersmith",
        "description": "-32°C ain't no problems!",
        "index_articles": 3
      },
      "plugins": [
        "./node_modules/wintersmith-coffee/"
      ]
    }
    

### Test

Test is written using [Mocha](https://mochajs.org/). Install it globally, then run

    $ mocha --compilers coffee:coffee-script
