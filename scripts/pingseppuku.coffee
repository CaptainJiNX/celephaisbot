# Description:
#   Tells pinger to commit suicide... :)

module.exports = (robot) ->
  robot.respond /PING$/i, (msg) ->
    msg.send msg.message.user.name + " seppuku"
