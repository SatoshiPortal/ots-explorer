FROM node:11-alpine as builder

RUN apk add --update --no-cache git python2 make g++ \
 && cd / \
 && git clone https://github.com/opentimestamps/opentimestamps.org.git \
 && cd opentimestamps.org \
 && npm install gulp-cli -g \
 && npm install gulp \
 && npm install --dev \
 && gulp default

FROM nginx:alpine

COPY --from=builder /opentimestamps.org /usr/share/nginx/html

EXPOSE 80

# docker build -t ots-explorer .
# docker network create --driver=overlay --attachable --opt encrypted nginxnet
# docker stack deploy -c docker-compose.yml ots-explorer

