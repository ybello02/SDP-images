FROM ubuntu:16.04

WORKDIR /client

COPY * /client/

# COPY installDependenciesAndclient.sh /client/
# COPY fwknopClient.sh /client/
# COPY sdp_ctrl_client.conf /client/
# COPY .fwknoprc /client/
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN ./installDependenciesAndclient.sh
CMD ["/bin/bash","-c", " ./fwknopClient.sh"]


