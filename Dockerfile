ARG RUBY_VERSION=3.3.5
FROM ruby:$RUBY_VERSION-slim as base

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential \
    libcairo2-dev libpango1.0-dev libgirepository1.0-dev

COPY Gemfile* .

RUN bundle install

COPY . .

EXPOSE 8080

CMD ["rackup", "--host", "0.0.0.0", "--port", "8080"]
