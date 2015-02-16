child_process = require 'child_process'

module.exports =
  checkTexPath: (builder) ->
    executable = builder.executable
    command = "type #{executable}"
    options = builder.constructChildProcessOptions()

    logResult = (status) ->
      console.log("Executable '#{executable}' in PATH? #{status}")

    proc = child_process.exec command, options, (error, stdout, stderr) ->
      if error?
        logResult('No...')
      else
        logResult('Yes!')
