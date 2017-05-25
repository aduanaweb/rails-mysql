# DOCKER FILE 

FROM ruby:2.4.0
MAINTAINER Márcio Luiz "marcio@interactsoftware.com.br"

# Install node & yarn
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/cache/apt \
    && npm install -g yarn
