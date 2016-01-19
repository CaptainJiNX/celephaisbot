FROM ctjinx/node-4.2.4
ENV REDISTOGO_URL="redis:celephaisbot-redis:6379"
ENV HUBOT_MEMEGEN_USERNAME="---"
ENV HUBOT_MEMEGEN_PASSWORD="---"
ENV HUBOT_EXTRA_MEMES="true"
ENV HUBOT_GOOGLE_CSE_KEY="---"
ENV HUBOT_GOOGLE_CSE_ID="---"
ENV TZ="Europe/Stockholm"
ENV HUBOT_SLACK_TOKEN="---"
CMD ["./bin/hubot", "-a", "slack"]
