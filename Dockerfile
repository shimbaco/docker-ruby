FROM jwilder/dockerize as dockerize
FROM node:10.16.3-alpine as node
FROM ruby:2.6.5-alpine

COPY --from=dockerize /usr/local/bin/dockerize /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

RUN apk update && \
    apk add -t \
      build-dependencies \
      build-base \
      tzdata \
      curl \
      git \
      imagemagick \
      # For `psql` command
      postgresql-client \
      postgresql-dev \
      yarn \
      chromium \
      chromium-chromedriver

RUN gem install bundler -v 2.0.2

CMD ["/bin/sh"]
