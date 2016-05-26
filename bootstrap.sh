#!/usr/bin/env bash
# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential libjudy-dev

install Ruby ruby2.3 ruby2.3-dev libsqlite3-dev
update-alternatives --set ruby /usr/bin/ruby2.3 >/dev/null 2>&1
update-alternatives --set gem /usr/bin/gem2.3 >/dev/null 2>&1

echo installing Bundler
gem install bundler -N >/dev/null 2>&1

install Git git

# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Download and compile libdogma
curl -Ls https://github.com/osmium-org/libdogma/releases/download/v1.2.0-cit10/libdogma-1.2.0-cit10.tar.xz | tar xJ
cd libdogma-1.2.0
CC=gcc ./configure --enable-debug
make
sudo make install

echo 'all set, rock on!'
