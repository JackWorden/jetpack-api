FROM ruby:2.2

RUN apt-get update && apt-get install -y build-essential \
  libssl-dev \
  libpq-dev \
  libxml2-dev \
  libxslt1-dev \
  libgmp3-dev \
  nodejs
  
RUN mkdir -p /jetpack
WORKDIR /jetpack

COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . ./
