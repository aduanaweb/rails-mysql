# DOCKER FILE 

FROM ubuntu:14.04

MAINTAINER Márcio Luiz "marcio@interactsoftware.com.br"

ENV HOME /root

# Update O.S.
RUN apt-get update -q
RUN apt-get install build-essential curl dkms git htop linux-headers-$(uname -r) \
                ntp python-software-properties software-properties-common \
                tmux tree unattended-upgrades unzip vim -q -y

# Install Ruby on Rails
RUN chmod +x /ruby.sh

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
