FROM ruby:2.2.1

MAINTAINER hiroshima-arc

RUN apt-get update -y && apt-get install -y \
    sqlite3
RUN gem install bundler

WORKDIR /usr/src/app

ADD . /usr/src/app
RUN bundle install

ENV RACK_ENV production

EXPOSE 9292
ENTRYPOINT ["/usr/local/bundle/bin/bundle","exec","exe/todo","server"]

