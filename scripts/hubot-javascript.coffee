# Description:
#   sandbox - run javascript in a sandbox!
#
# Dependencies:
#   "sandbox": "0.8.3"
#
# Configuration:
#   None
#
# Commands:
#   hubot (run|sandbox|js) <javascript> - Execute the javascript code
#
# Author:
#   ajacksified
#

Sandbox = require('sandbox')

module.exports = (robot) ->
  robot.respond /(run|sandbox|js) (.*)/i, (msg) ->
    if msg.message.user.name == 'goatbot'
      msg.send "Haha, you wish..."
      return

    sandbox = new Sandbox
    sandbox.run(msg.match[2], (output) ->
      msg.send output.result
    )
