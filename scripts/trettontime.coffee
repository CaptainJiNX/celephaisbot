# Description:
#
#   Robot tells the time is 13:37
#
# Dependencies:
#
#   cron
#

cronjob = require("cron").CronJob
random = require('hubot').Response.prototype.random

TRETTON_TIME = "0 37 13 * * 1-5" # M-F 13:37
ROOM = "general"

responses = [
  "It's 13:37!",
  "You know what time it is? It's 13:37!",
  "13:37! It's the leet moment you've been waiting on.",
  "Ladies and gentlemen, it is now 13:37. Carry on and be awesome.",
  "Just so y'all know. It's 13:37.",
  "LOL, 13:37!",
  "One, two, Freddy's coming for you. Three, four, better lock your door. One, three, three, seven, it goes up to ELEVEN!",
  "Tick, tock, tick, tock... Time is 13:37. Tick, tock, tickety-tock..."
  ]

module.exports = (robot) ->
  remind = new cronjob TRETTON_TIME,
    -> robot.messageRoom ROOM, random responses
    null
    true
