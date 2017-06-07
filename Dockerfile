# DOCKER FILE 

FROM ruby:2.3.1
ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 6.9.2

MAINTAINER Márcio Luiz "marcio@interactsoftware.com.br"

RUN adduser -D -u 1000 ubuntu \
    && apk add --no-cache \
        libstdc++ \
    && apk add --no-cache --virtual .build-deps \
        binutils-gold \
        curl \
        g++ \
        gcc \
        gnupg \
        libgcc \
        linux-headers \
        make \
        python \
    && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.xz" \
    && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
    && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
    && grep " node-v$NODE_VERSION.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
    && tar -xf "node-v$NODE_VERSION.tar.xz" \
    && cd "node-v$NODE_VERSION" \
    && ./configure \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install \
    && apk del .build-deps \
    && cd .. \
    && rm -Rf "node-v$NODE_VERSION" \
    && rm "node-v$NODE_VERSION.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt
    
RUN apk add --no-cache --virtual .build-deps \
      binutils-gold \
      curl \
      g++ \
      gcc \
      gnupg \
      libgcc \
      linux-headers \
      make \
      python \
      sqlite-dev \
  && gem install bundler \
  && rails new --skip-turbolinks --skip-spring ./tmpapp \
  && rm -rf tmpapp
