FROM ubuntu:16.04

EXPOSE 4444

WORKDIR /gateway

COPY * /gateway/
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN ./installDependencies.sh
CMD ["/bin/bash","-c", " ./fwknopSetup.sh $SERVER_HOSTNAME"]


