#!/usr/bin/env bash
USER root
echo "Installing dependencies..."
apt-get update -y
apt-get -y install texinfo libtool autoconf make telnet openssl libssl-dev libjson0 libjson0-dev libpcap-dev git

echo "Setting up Waverley Labs fwknop client..."
git clone https://github.com/WaverleyLabs/fwknop.git
cd fwknop
libtoolize --force
aclocal
autoheader
automake --force-missing --add-missing
autoconf
./configure --disable-server --prefix=/usr
make
make install



