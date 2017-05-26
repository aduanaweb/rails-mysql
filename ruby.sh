#!/bin/bash -eux

# Install ruby and rails dependencies
apt-get install imagemagick libcurl4-openssl-dev libmagickwand-dev libqt4-dev \
                libreadline-dev libsqlite3-dev libssl-dev libv8-dev \
                libxml2-dev libxslt1-dev libyaml-dev sqlite3 zlib1g-dev -q -y 

# Add rbenv paths and eval to .bashrc and .bash_profile (needed in login/non-login shells)
read -d '' RBENV_SNIPPET <<"EOF"
export RBENV_ROOT="${HOME}/.rbenv"

if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi
EOF
echo "$RBENV_SNIPPET" | tee -a /home/ubuntu/.profile

# Install rbenv
read -d '' RBENV_INSTALL <<"EOF"
git clone git://github.com/rbenv/rbenv.git $RBENV_ROOT

PLUGINS=(
  rbenv/rbenv-vars
  rbenv/ruby-build
  rbenv/rbenv-default-gems
  rkh/rbenv-update
  rkh/rbenv-whatis
  dcarley/rbenv-sudo
)

for plugin in ${PLUGINS[@]} ; do
  KEY=${plugin%%/*}
  VALUE=${plugin#*/}

  RBENV_PLUGIN_ROOT="${RBENV_ROOT}/plugins/$VALUE"
  git clone https://github.com/$KEY/$VALUE.git $RBENV_PLUGIN_ROOT
done
EOF
su - ubuntu -c "$RBENV_INSTALL"

# Install ruby
read -d '' RUBY_INSTALL <<EOF
echo "gem: --no-ri --no-rdoc" >> ~/.gemrc
rbenv install -v -k $ruby_version;
rbenv global $ruby_version;
gem install bundler;
EOF
su - ubuntu -c "$RUBY_INSTALL"
