# DOCKER FILE 

FROM ubuntu:14.04

MAINTAINER Márcio Luiz "marcio@interactsoftware.com.br"

ENV HOME /root

# Install ruby and rails dependencies
RUN apt-get install imagemagick libcurl4-openssl-dev libmagickwand-dev libqt4-dev \
                libreadline-dev libsqlite3-dev libssl-dev libv8-dev \
                libxml2-dev libxslt1-dev libyaml-dev sqlite3 zlib1g-dev -q -y 

# Add rbenv paths and eval to .bashrc and .bash_profile (needed in login/non-login shells)
RUN read -d '' RBENV_SNIPPET <<"EOF"
RUN export RBENV_ROOT="${HOME}/.rbenv"

RUN if [ -d "${RBENV_ROOT}" ]; then
        export PATH="${RBENV_ROOT}/bin:${PATH}"
        eval "$(rbenv init -)"
    fi
    EOF
    echo "$RBENV_SNIPPET" | tee -a /home/ubuntu/.profile

# Install rbenv
RUN read -d '' RBENV_INSTALL <<"EOF"
RUN git clone git://github.com/rbenv/rbenv.git $RBENV_ROOT

RUN PLUGINS=(
      rbenv/rbenv-vars
      rbenv/ruby-build
      rbenv/rbenv-default-gems
      rkh/rbenv-update
      rkh/rbenv-whatis
      dcarley/rbenv-sudo
    )

RUN for plugin in ${PLUGINS[@]} ; do
      KEY=${plugin%%/*}
      VALUE=${plugin#*/}

      RBENV_PLUGIN_ROOT="${RBENV_ROOT}/plugins/$VALUE"
      git clone https://github.com/$KEY/$VALUE.git $RBENV_PLUGIN_ROOT
    done
    EOF
RUN su - ubuntu -c "$RBENV_INSTALL"

# Install ruby
RUN read -d '' RUBY_INSTALL <<EOF
RUN echo "gem: --no-ri --no-rdoc" >> ~/.gemrc
RUN rbenv install -v -k $ruby_version;
RUN rbenv global $ruby_version;
RUN gem install bundler;
RUN EOF
RUN su - ubuntu -c "$RUBY_INSTALL"

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
