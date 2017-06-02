# DOCKER FILE 

FROM alpine

MAINTAINER Márcio Luiz "marcio@interactsoftware.com.br"

ENV HOME /root

WORKDIR /root

# Update O.S.
RUN apt-get update -q
RUN apt-get install build-essential curl dkms git htop linux-headers-$(uname -r) \
                ntp python-software-properties software-properties-common \
                tmux tree unattended-upgrades unzip vim -q -y

# Install Ruby on Rails

RUN apk add --no-cache --update ca-certificates ruby ruby-dev musl-dev gcc make

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

# Cleanup
RUN apt-get autoremove -y

CMD ["/sbin/my_init"]
