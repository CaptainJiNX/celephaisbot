# Description:
#   Hubot delivers a random demoscene production of any type. Uses data from http://demozoo.org
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot demo me - Displays a random demoscene production.
#
# Author:
#   captain jinx

module.exports = (robot) ->
  robot.respond /demo me/i, (msg) ->

    if msg.message.user.name == 'goatbot'
      msg.send "You don't want to see a demo right now... Move along."
      return;

    msg.http('http://demozoo.org/api/v1/productions/').get() (err, res, body) ->
      result = JSON.parse(body)
      totalCount = result.count
      pageSize = result.results.length
      pageCount = Math.floor(totalCount / pageSize)
      randomPage = Math.floor(Math.random() * pageCount) + 1

      msg.http('http://demozoo.org/api/v1/productions/?page=' + randomPage).get() (err, res, body) ->
        production = msg.random JSON.parse(body).results

        name = (x) -> x.name
        joined = (list) -> (list.map name).join '/'

        authors = joined production.author_nicks
        types = joined production.types

        msg.send "Check out this #{types} *#{production.title}* from #{authors}"
        msg.send "http://demozoo.org/productions/#{production.id}/"
