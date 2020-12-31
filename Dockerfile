# Use the official Ruby image.
# https://hub.docker.com/_/ruby
FROM ruby:3.0-slim

# Install production dependencies.
RUN apt-get update && \
    apt-get install -V -y libgirepository1.0-dev
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
ENV BUNDLE_FROZEN=true
RUN bundle install

# Copy local code to the container image.
COPY . .

# Run the web service on container startup.
CMD ["ruby", "./app.rb"]
