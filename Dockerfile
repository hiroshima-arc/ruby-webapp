FROM ruby:2.2.1

MAINTAINER hiroshima-arc

RUN apt-get update -y && apt-get install -y \
    sqlite3 \
    curl

RUN gem install bundler rack

WORKDIR /app

VOLUME /app

EXPOSE 9292

ENTRYPOINT ["/bin/bash"]

