FROM node:9.4.0-alpine
RUN apk add -U tzdata
RUN cp /usr/share/zoneinfo/Europe/Stockholm /etc/localtime

ENV REDISTOGO_URL="redis:celephaisbot-redis:6379"
ENV HUBOT_MEMEGEN_USERNAME="---"
ENV HUBOT_MEMEGEN_PASSWORD="---"
ENV HUBOT_EXTRA_MEMES="true"
ENV HUBOT_GOOGLE_CSE_KEY="---"
ENV HUBOT_GOOGLE_CSE_ID="---"
ENV HUBOT_SLACK_TOKEN="---"

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install -q --production

COPY external-scripts.json ./
COPY bin ./bin
COPY lib ./lib
COPY scripts ./scripts

CMD ["./bin/hubot", "-a", "slack"]
