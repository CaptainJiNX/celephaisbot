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

dayName = (day) ->
  return "monday" if day == 1
  return "tuesday" if day == 2
  return "wednesday" if day == 3
  return "thursday" if day == 4
  return "friday" if day == 5
  return "saturday" if day == 6
  return "sunday" if day == 0

module.exports = (robot) ->
  robot.respond /is it friday/i, (msg) ->

    if msg.message.user.name == 'goatbot'
      msg.send "My dear goatbot... for you it's an eternal monday."
      return;

    today = new Date()
    day = today.getDay()

    if today.getDay() != 5
      msg.send "Nope, but you are still allowed to drink beer on a " + dayName(day) + "!"
      msg.send "goatbot beer me"
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
