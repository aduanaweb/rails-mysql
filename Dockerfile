# DOCKER FILE 

FROM ruby:2.4.0
# FROM phusion/passenger-ruby24

MAINTAINER Márcio Luiz "marcio@interactsoftware.com.br"

ENV HOME /root

# Install Node.js and other dependencies
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - \
  && apt-get install -y \
  nodejs \
  libpcre3-dev \
  libcurl4-gnutls-dev \
  libgmp3-dev \
  mysql-client \
  postgresql-client \
  imagemagick \
  libmagickwand-dev \
  graphviz \
  wget

RUN gem install bundler --no-ri --no-rdoc

# Cleanup
RUN apt-get autoremove -y

WORKDIR /home/app

CMD ["/sbin/my_init"]
