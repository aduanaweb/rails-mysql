# DOCKER FILE 

FROM       ubuntu:14.04
MAINTAINER Márcio Luiz "marcio@interactsoftware.com.br"

# Install dependency packages
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git
RUN apt-get clean

# Deploy rbenv and ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
ENV RBENV_ROOT /root/.rbenv
ENV PATH /root/.rbenv/bin:/root/.rbenv/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ADD ./rbenv.sh /etc/profile.d/rbenv.sh

# Install Ruby
RUN rbenv install 2.4.0
RUN rbenv global 2.4.0
RUN rbenv rehash

# Install Bundler
RUN gem install --no-ri --no-rdoc bundler

# Install Rails
RUN gem install rails-4.2.6

# Install Curl and Node.js (for asset pipeline)
RUN apt-get install -qq -y curl
RUN apt-get install -qq -y nodejs
