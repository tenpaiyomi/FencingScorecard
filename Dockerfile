FROM ruby:3.1.2-slim-buster

ARG OVERMIND_VERSION=v2.2.2
ARG TARGETARCH=amd64

ENV BUNDLE_PATH vendor/bundle

RUN apt-get update && apt-get -y --no-install-recommends install software-properties-common \
                                                                 curl \
                                                                 unzip \
                                                                 gnupg \
                                                                 less \
                                                                 build-essential \
                                                                 ssh \
                                                                 git \
                                                                 tmux \
                                                                 postgresql-client \
                                                                 libpq-dev && \
  curl -fsSL https://deb.nodesource.com/setup_17.x | bash - && \
  apt update -y && \
  apt install nodejs -y && \
  npm install -g yarn && \
  gem update --system && \
  # Install overmind [development usage, for now]
  curl -L -O https://github.com/DarthSim/overmind/releases/download/${OVERMIND_VERSION}/overmind-${OVERMIND_VERSION}-linux-${TARGETARCH}.gz && \
  gzip -d overmind-${OVERMIND_VERSION}-linux-${TARGETARCH}.gz && \
  mv overmind-${OVERMIND_VERSION}-linux-${TARGETARCH} /usr/bin/overmind && \
  chmod +x /usr/bin/overmind && \
  #
  # Cleanup
  rm -rf /var/lib/apt/lists/* linux-install-${CLJ_VERSION}.sh overmind-${OVERMIND_VERSION}-linux-${TARGETARCH}.gz && \
  apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false