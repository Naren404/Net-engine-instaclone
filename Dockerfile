FROM ruby:3.0-alpine

WORKDIR /usr/src/app

RUN apk add --no-cache \
  build-base \
  busybox \
  ca-certificates \
  curl \
  git \
  libffi-dev \
  libsodium-dev \
  nodejs \
  postgresql-dev \
  yarn \
  tzdata

EXPOSE 3000
