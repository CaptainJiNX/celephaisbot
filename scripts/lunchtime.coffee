# Description:
#
#   Hubot tells it's time for lunch.
#
# Dependencies:
#
#   cron
#

cronjob = require("cron").CronJob
random = require('hubot').Response.prototype.random

LUNCH_TIME = "0 02 11 * * 1-5" # M-F 13:37
ROOM = "general"

responses = [
  "Klockan är 11.02, dags för lunch. All annan verksamhet upphör!",
  "11.02, samla ihop era lunchkamrater!",
  "It's eleven oh two, you all know what to do! :pizzaspin: :pizzaspin: :pizzaspin:",
  "Släpp tangentbordet omedelbart! Nu är det 11.02, så tåga iväg och ät något! :hamburger:",
  "Det är dags för :fiskbulle:, klockan är 11.02 nu! Släpp allt du gör!",
  "Ok, sluta fundera på mikrotjänster och monoliter, dags för lunch. Klockan är ju 11.02.",
  "Fooooood time!!!!! 11.02! :time:",
  "Nu är klockan 11.02, vi ska äta lunch nu, och du ska med!",
  ":poultry_leg: :point_right: 11.02 :point_left: :beer: - You know what time it is!",
  "11.02! Nu går lunchtåget! :conga-parrot::conga-parrot::conga-parrot::conga-parrot:",
  "11.02 <---- !!!!",
  "Missa inte chansen att äta en välsmakande lunch nu, klockan är ju ändå 11.02!",
  "Vad ska vi äta för lunch i dag då? Indiskt kanske? Hur som helst är ju klockan 11.02...",
  "11.02! Hamburgare, pizza eller kanske stuvade makaroner? Dags att tåga iväg iaf.",
  "Nu är lunchtimmen slagen, plocka fram matlådan för dagen. När jag säger elva noll två, är det dags att gå...",
  "11.02! Vem är på?",
  "Nu när uret visar 11.02, finns stora chanser att matlåda få.",
  ":one::one:  :zero::two:",
]

module.exports = (robot) ->
  remind = new cronjob LUNCH_TIME,
    -> robot.messageRoom ROOM, random responses
    null
    true
