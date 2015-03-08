Composer = require './composer'
ConfigSchema = require './config-schema'

module.exports =
  config: ConfigSchema

  activate: ->
    @prepareGlobalObject()
    @composer = new Composer()

    atom.commands.add 'atom-workspace', 'latex:build', => @composer.build()
    atom.commands.add 'atom-workspace', 'latex:sync', => @composer.sync()
    atom.commands.add 'atom-workspace', 'latex:clean', => @composer.clean()

  consumeStatusBar: (statusBar) ->
    @composer.setStatusBar(statusBar)

  prepareGlobalObject: ->
    window.atom = {} unless atom?
    atom.latex = {} unless atom.latex?
