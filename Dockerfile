FROM node:8.8.1-alpine
RUN apk add -U tzdata
RUN cp /usr/share/zoneinfo/Europe/Stockholm /etc/localtime

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install -q --production

COPY external-scripts.json hubot-scripts.json ./
COPY bin ./bin
COPY lib ./lib
COPY scripts ./scripts

ENV REDISTOGO_URL="redis:celephaisbot-redis:6379"
ENV HUBOT_MEMEGEN_USERNAME="---"
ENV HUBOT_MEMEGEN_PASSWORD="---"
ENV HUBOT_EXTRA_MEMES="true"
ENV HUBOT_GOOGLE_CSE_KEY="---"
ENV HUBOT_GOOGLE_CSE_ID="---"
ENV HUBOT_SLACK_TOKEN="---"
CMD ["./bin/hubot", "-a", "slack"]
