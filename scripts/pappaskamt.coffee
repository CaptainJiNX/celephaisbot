# Description:
#   Hubot delivers a pappaskämt
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot pappaskämt - Delivers a random pappaskämt
#
# Author:
#   captain jinx

module.exports = (robot) ->
  robot.respond /pappaskämt/i, (msg) ->

    if msg.message.user.name == 'goatbot'
      msg.send "Din mamma kan vara ett pappaskämt."
      return;

    msg.http('https://www.reddit.com/r/pappaskamt.json')
      .header('accept', 'application/json')
      .header('cookie', 'reddit_session=true;')
      .get() (err, res, body) ->
        item = msg.random JSON.parse(body).data.children.filter (item) ->
          item.data.url != undefined

        if !item
          msg.send "Finns inga pappaskämt just nu..."
          return

        msg.send item.data.url

        if item.data.title != "Dagens"
          msg.send item.data.title
