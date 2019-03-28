# DOCKER FILE 

FROM ruby:2.5.1
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
  && apt-get install -y mysql-server mysql-client --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# This Dockerfile doesn't need to have an entrypoint and a command
# as Bitbucket Pipelines will overwrite it with a bash script.
