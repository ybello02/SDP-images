FROM ubuntu:14.04

WORKDIR /client
COPY * /client/
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN echo "Installing dependencies..."
RUN apt-get update -y && apt-get install -y texinfo libtool autoconf make telnet openssl libssl-dev libjson0 libjson0-dev libpcap-dev git

RUN echo "Setting up Waverley Labs fwknop client..."
RUN git clone https://github.com/WaverleyLabs/fwknop.git
WORKDIR fwknop
RUN libtoolize --force && aclocal && autoheader && automake --force-missing --add-missing && autoconf && \
    ./configure --disable-server --prefix=/usr && make && make install

WORKDIR /client

CMD ["/bin/bash","-c", " ./fwknopClient.sh"]


