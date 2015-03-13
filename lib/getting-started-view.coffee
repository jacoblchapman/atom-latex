{Disposable} = require 'atom'
{$, ScrollView} = require 'atom-space-pen-views'

module.exports =
class GettingStartedView extends ScrollView
  @content: ->
    @div class: 'latex getting-started pane-item padded', =>
      @h1 'Getting started with LaTeX in Atom'

      @section =>
        @div =>
          @raw '''
            Lorem ipsum dolor sit amet
            '''

  @deserialize: (options = {}) ->
    new GettingStartedView(options)

  serialize: ->
    deserializer: @constructor.name
    uri: @getURI()

  initialize: -> return

  getURI: -> @uri
  getTitle: -> 'LaTeX: Getting Started'

  isEqual: (other) ->
    other instanceof GettingStartedView

  onDidChangeTitle: -> new Disposable() -> return
  onDidChangeModified: -> new Disposable() -> return
