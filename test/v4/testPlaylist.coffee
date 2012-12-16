assert   = require 'assert'
vows     = require 'vows'
echonest = require '../../lib/echonest'
util = require '../util'

checkErrors = util.checkErrors

vows.describe('playlist methods').addBatch({
  'when using echonest':
    topic: new echonest.Echonest
    "to create a basic artist-radio playlist from behold... the arctopus":
      topic: (nest) ->
        nest.playlist.basic {
          artist: "behold... the arctopus"
          type: "artist-radio"
        }, @callback
        undefined
      'i get some tunes': (err, response) ->
        assert.ok response.songs.length > 1
      'we see no errors': checkErrors
    "to create a static artist-radio playlist from behold... the arctopus":
      topic: (nest) ->
        nest.playlist.basic {
          artist: "behold... the arctopus"
          type: "artist-radio"
        }, @callback
        undefined
      'i get some tunes': (err, response) ->
        assert.ok response.songs.length > 1
      'we see no errors': checkErrors
    "to create a dynamic artist-radio playlist from behold... the arctopus":
      topic: (nest) ->
        nest.playlist.dynamic.create {
          artist: "behold... the arctopus"
          type: "artist-radio"
        }, @callback
        undefined
      'i get a session id': (err, response) ->
        assert.ok response.session_id != null
      'I can resume my session':
        topic: (response, nest) ->
          nest.playlist.dynamic.restart {
            session_id: response.session_id
          }, @callback
        'and get still get a session id': (err, response) ->
          assert.ok response.session_id != null
      'we see no errors': checkErrors
}).export module
