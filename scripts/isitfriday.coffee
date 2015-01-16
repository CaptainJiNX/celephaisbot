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

    msg.send "YES IT IS FRIDAY!!!"

    msg.http('http://www.reddit.com/r/holdmybeer.json')
      .get() (err, res, body) ->
        result = JSON.parse(body)

        items = [ ]
        for child in result.data.children
          if child.data.domain != "self.holdmybeer"
            items.push({ url: child.data.url, title: child.data.title.replace('HMB', 'Hold my beer').replace('beer', ':beer:') })

        if items.count <= 0
          msg.send "Couldn't find anything awesome..."
          return

        rnd = Math.floor(Math.random()*items.length)
        picked_item = items[rnd]

        parsed_url = url.parse(picked_item.url)
        if parsed_url.host == "imgur.com"
          parsed_url.host = "i.imgur.com"
          parsed_url.pathname = parsed_url.pathname + ".jpg"

          picked_item.url = url.format(parsed_url)

        msg.send picked_item.title
        msg.send picked_item.url
