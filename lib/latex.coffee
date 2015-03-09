module.exports =
class Latex
  initialize: ->
    @setDefaultBuilder()
    @setDefaultLogger()
    @setDefaultOpener()

  getBuilder: -> @builder
  getLogger: -> @logger
  getOpener: -> @opener

  log:
    error: (statusCode, result, builder) -> @logger.error(statusCode, result, builder)
    warning: (message) -> @logger.warning(message)
    info: (message) -> @logger.info(message)

  setDefaultBuilder: ->
    LatexmkBuilder = require './builders/latexmk'
    @builder = new LatexmkBuilder()

  setDefaultLogger: ->
    ConsoleLogger = require './loggers/console-logger'
    @logger = new ConsoleLogger()

  setDefaultOpener: ->
    OpenerImpl = switch process.platform
      when 'darwin'
        if fs.existsSync(atom.config.get('latex.skimPath'))
          require './openers/skim-opener'
        else
          require './openers/preview-opener'
      when 'win32'
        if fs.existsSync(atom.config.get('latex.sumatraPath'))
          require './openers/sumatra-opener'
    unless OpenerImpl?
      if atom.packages.resolvePackagePath('pdf-view')?
        OpenerImpl = require './openers/atompdf-opener'
      else
        @log.warning('No PDF opener found. For cross-platform viewing,
          install the pdf-view package.')
        return

    @opener = new OpenerImpl()

  resolveOpenerImplementation: (platform) ->
    OpenerImpl = switch platform
      when 'darwin'
        if fs.existsSync(atom.config.get('latex.skimPath'))
          require './openers/skim-opener'
        else
          require './openers/preview-opener'
      when 'win32'
        if fs.existsSync(atom.config.get('latex.sumatraPath'))
          require './openers/sumatra-opener'
    unless OpenerImpl?
      if atom.packages.resolvePackagePath('pdf-view')?
        OpenerImpl = require './openers/atompdf-opener'
      else
        @log.warning('No PDF opener found. For cross-platform viewing,
          install the pdf-view package.')
        return
