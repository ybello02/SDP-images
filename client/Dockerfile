FROM ubuntu:16.04

RUN echo "Installing dependencies..."
RUN apt-get update -y
RUN apt-get -y install texinfo libtool autoconf make telnet openssl libssl-dev libjson0 libjson0-dev libpcap-dev git

RUN echo "Setting up Waverley Labs fwknop client..."
RUN git clone https://github.com/WaverleyLabs/fwknop.git
RUN cd fwknop
RUN libtoolize --force
RUN aclocal
RUN autoheader
RUN automake --force-missing --add-missing
RUN autoconf
RUN ./configure --disable-server --prefix=/usr
RUN make
RUN make install

WORKDIR /client

COPY * /client/

# COPY installDependenciesAndclient.sh /client/
# COPY fwknopClient.sh /client/
# COPY sdp_ctrl_client.conf /client/
# COPY .fwknoprc /client/
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
# RUN ./installDependenciesAndclient.sh
CMD ["/bin/bash","-c", " ./fwknopClient.sh"]


