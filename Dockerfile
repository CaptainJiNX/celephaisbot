FROM node:4.2.4-slim
ENV EXTERNAL_PORT 80
EXPOSE $EXTERNAL_PORT
ENV NODE_VERSION 4.2.4
RUN mkdir -p /app
WORKDIR /app

ONBUILD COPY package.json /app
ONBUILD RUN npm install -q --production
ONBUILD COPY . /app
ENTRYPOINT ["node", "."]
