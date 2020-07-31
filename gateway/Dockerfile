FROM ubuntu:16.04

WORKDIR /gateway

COPY * /gateway/

RUN echo "Installing dependencies..."
RUN apt-get update -y
RUN apt-get install -y curl git openssl libssl-dev libjson0 libjson0-dev libpcap-dev texinfo libtool autoconf make iptables

RUN echo "Install FWKNOP"
RUN git clone https://github.com/waverleylabs/fwknop.git
RUN cd fwknop
RUN libtoolize --force
RUN aclocal
RUN autoheader
RUN automake --force-missing --add-missing
RUN autoconf
RUN ./configure -disable-client --prefix=/usr --sysconfdir=/etc
RUN make
RUN make install
EXPOSE 4444

# WORKDIR /gateway

# COPY * /gateway/
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
# RUN ./installDependencies.sh
CMD ["/bin/bash","-c", " ./fwknopSetup.sh $SERVER_HOSTNAME"]


