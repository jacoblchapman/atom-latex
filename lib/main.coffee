{CompositeDisposable} = require 'atom'
Composer = require './composer'
ConfigSchema = require './config-schema'

GettingStartedUri = 'atom://latex/getting-started'

createGettingStartedView = (state) ->
  GettingStartedView = require './getting-started-view'
  new GettingStartedView(state)

atom.deserializers.add
  name: 'GettingStartedView'
  deserialize: (state) -> createGettingStartedView(state)

module.exports =
  config: ConfigSchema

  activate: ->
    require './bootstrap'
    @composer = new Composer()
    @disposables = new CompositeDisposable()

    @disposables.add atom.commands.add 'atom-workspace', 'latex:build', => @composer.build()
    @disposables.add atom.commands.add 'atom-workspace', 'latex:sync', => @composer.sync()
    @disposables.add atom.commands.add 'atom-workspace', 'latex:clean', => @composer.clean()

    @disposables.add atom.commands.add 'atom-workspace', 'latex:show-getting-started', =>
      @showGettingStarted()

    @disposables.add atom.workspace.addOpener (filePath) ->
      createGettingStartedView(uri: GettingStartedUri) if filePath is GettingStartedUri

  deactivate: ->
    @disposables.dispose()

  consumeStatusBar: (statusBar) ->
    @composer.setStatusBar(statusBar)

  showGettingStarted: ->
    atom.workspace.open(GettingStartedUri)
