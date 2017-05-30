# DOCKER FILE 

FROM ubuntu:14.04

MAINTAINER Márcio Luiz "marcio@interactsoftware.com.br"

ENV HOME /root

WORKDIR /root

# Update O.S.
RUN apt-get update -q
RUN apt-get install build-essential curl dkms git htop linux-headers-$(uname -r) \
                ntp python-software-properties software-properties-common \
                tmux tree unattended-upgrades unzip vim -q -y

# Install Ruby on Rails

# Install ruby and rails dependencies
RUN apt-get install imagemagick libcurl4-openssl-dev libmagickwand-dev libqt4-dev \
                libreadline-dev libsqlite3-dev libssl-dev libv8-dev \
                libxml2-dev libxslt1-dev libyaml-dev sqlite3 zlib1g-dev -q -y 
                
CMD read -d '' RBENV_SNIPPET <<"EOF" 

CMD export RBENV_ROOT="${HOME}/.rbenv" 

CMD if [ -d "${RBENV_ROOT}" ]; then \
      export PATH="${RBENV_ROOT}/bin:${PATH}" \ 
      eval "$(rbenv init -)" \
    fi \
EOF
    
CMD echo "$RBENV_SNIPPET" | tee -a /home/ubuntu/.profile

# Install rbenv
CMD read -d '' RBENV_INSTALL <<"EOF" 

CMD git clone git://github.com/rbenv/rbenv.git $RBENV_ROOT 

CMD PLUGINS=( \
  rbenv/rbenv-vars \
  rbenv/ruby-build \
  rbenv/rbenv-default-gems \
  rkh/rbenv-update \
  rkh/rbenv-whatis \
  dcarley/rbenv-sudo \
) 

CMD for plugin in ${PLUGINS[@]} ; do \
  KEY=${plugin%%/*} \
  VALUE=${plugin#*/} \
  RBENV_PLUGIN_ROOT="${RBENV_ROOT}/plugins/$VALUE" \
  git clone https://github.com/$KEY/$VALUE.git $RBENV_PLUGIN_ROOT \
done \
EOF

CMD su - ubuntu -c "$RBENV_INSTALL"

# Install ruby
CMD read -d '' RUBY_INSTALL <<EOF
CMD echo "gem: --no-ri --no-rdoc" >> ~/.gemrc
CMD rbenv install -v -k $ruby_version; 
CMD rbenv global $ruby_version; 
CMD gem install bundler; 
CMD EOF

CMD su - ubuntu -c "$RUBY_INSTALL"

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
