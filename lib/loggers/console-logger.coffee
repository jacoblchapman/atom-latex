Logger = require '../logger'

module.exports =
class ConsoleLogger extends Logger
  error: (statusCode, result, builder) ->
    console.group('LaTeX errors')
    switch statusCode
      when 127
        executable = 'latexmk' # TODO: Read from Builder::executable in the future.
        console.log(
          """
          %cTeXification failed! Builder executable '#{executable}' not found.

            latex.texPath
              as configured: #{atom.config.get('latex.texPath')}
              when resolved: #{builder.constructPath()}

          Make sure latex.texPath is configured correctly; either adjust it \
          via the settings view, or directly in your config.cson file.
          """, 'color: red')
      else
        if result?.errors?
          console.group("TeXification failed with status code #{statusCode}")
          for error in result.errors
            console.log("%c#{error.filePath}:#{error.lineNumber}: #{error.message}", 'color: red')
          console.groupEnd()
        else
          console.log("%cTeXification failed with status code #{statusCode}", 'color: red')
    console.groupEnd()

  warning: (message) ->
    console.group('LaTeX warnings')
    console.log(message)
    console.groupEnd()

  info: (message) ->
    console.group('LaTeX info')
    console.log(message)
    console.groupEnd()
