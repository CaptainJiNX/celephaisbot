FROM node:19.8.1-buster-slim

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY external-scripts.json ./
COPY bin ./bin
COPY lib ./lib
COPY scripts ./scripts

ENV TZ="Europe/Stockholm"

CMD ["./bin/hubot", "-a", "slack"]
