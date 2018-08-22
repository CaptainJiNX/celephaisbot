FROM node:10.9.0-alpine
RUN apk add -U tzdata
RUN cp /usr/share/zoneinfo/Europe/Stockholm /etc/localtime

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install -q --production

COPY external-scripts.json ./
COPY bin ./bin
COPY lib ./lib
COPY scripts ./scripts

CMD ["./bin/hubot", "-a", "slack"]
