FROM ubuntu:16.04

EXPOSE 5000
EXPOSE 22
WORKDIR /controller
COPY * /controller/
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN ./installDependencies.sh
RUN ./setupMySQL.sh
RUN ./Gencerts.sh
CMD ["/bin/bash", "-c","/controller/runController.sh"]


