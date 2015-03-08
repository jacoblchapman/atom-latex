module.exports =
class Logger
  error: (statusCode, result, builder) -> undefined
  warning: (message) -> undefined
  info: (message) -> undefined

  @initialize: ->
    atom.latex.log = @getLogger()

  @getLogger: ->
    ConsoleLogger = require './loggers/console-logger'
    new ConsoleLogger()
