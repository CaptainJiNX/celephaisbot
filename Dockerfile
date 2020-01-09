FROM node:12.14.1-alpine
RUN apk add -U tzdata
RUN cp /usr/share/zoneinfo/Europe/Stockholm /etc/localtime

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY external-scripts.json ./
COPY bin ./bin
COPY lib ./lib
COPY scripts ./scripts

CMD ["./bin/hubot", "-a", "slack"]
