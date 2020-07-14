FROM ruby:2.5-slim

RUN apt update && apt install -qq -y --no-install-recommends \
    build-essential nodejs libpq-dev

ENV INSTALL_PATH /onebitchat

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile ./

COPY . .