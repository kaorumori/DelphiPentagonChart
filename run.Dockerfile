FROM gcr.io/buildpacks/gcp/run:v1
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
  libcairo2-dev libpango1.0-dev libgirepository1.0-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
USER cnb
