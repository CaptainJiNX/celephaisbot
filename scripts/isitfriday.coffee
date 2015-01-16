# Description:
#   Hubot delivers a pic from Reddit's /r/holdmybeer frontpage if it's friday
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot is it friday - Display the picture from /r/holdmybeer if it's friday
#
# Author:
#   captain jinx

url = require("url")

module.exports = (robot) ->
  robot.respond /is it friday/i, (msg) ->
    search = escape(msg.match[1])

    today = new Date()

    if today.getDay() != 5
      msg.send "Nope... not friday yet. "
      return

    msg.http('http://www.reddit.com/r/holdmybeer.json')
      .get() (err, res, body) ->
        result = JSON.parse(body)

        urls = [ ]
        for child in result.data.children
          if child.data.domain != "self.holdmybeer"
            urls.push(child.data.url)

        if urls.count <= 0
          msg.send "Couldn't find anything cute..."
          return

        rnd = Math.floor(Math.random()*urls.length)
        picked_url = urls[rnd]

        parsed_url = url.parse(picked_url)
        if parsed_url.host == "imgur.com"
          parsed_url.host = "i.imgur.com"
          parsed_url.pathname = parsed_url.pathname + ".jpg"

          picked_url = url.format(parsed_url)

        msg.send picked_url
