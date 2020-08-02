FROM ubuntu:14.04

WORKDIR /gateway
COPY * /gateway/

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN echo "Installing dependencies..."
RUN apt-get update -y && apt-get install -y curl git openssl libssl-dev libjson0 libjson0-dev libpcap-dev texinfo libtool autoconf make iptables

RUN echo "Install FWKNOP"
RUN git clone https://github.com/waverleylabs/fwknop.git
WORKDIR fwknop
RUN libtoolize --force && aclocal && autoheader && automake --force-missing --add-missing && autoconf && \
    ./configure -disable-client --prefix=/usr --sysconfdir=/etc && make && make install
    
WORKDIR /gateway

RUN echo "Copying config files..."
RUN yes | cp access.conf /etc/fwknop/ && yes | cp fwknopd.conf /etc/fwknop/ && yes | cp gate_sdp_ctrl_client.conf /etc/fwknop/ && \
    yes | cp gate.fwknoprc /etc/fwknop/

EXPOSE 4444

CMD ["/bin/bash","-c", " ./fwknopSetup.sh $SERVER_HOSTNAME"]


