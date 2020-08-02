FROM ubuntu:14.04

WORKDIR /controller
COPY * /controller/

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN echo "Doing intial setup..."

RUN apt-get update -y && apt-get install -y curl git && curl -sL https://deb.nodesource.com/setup_8.x | bash - && apt-get install -y nodejs

RUN echo "Cloning SDPController project from Waverley..."
RUN git clone https://github.com/waverleylabs/SDPController.git && yes | cp -rf config.js SDPController/config.js  && cd SDPController && npm install

COPY setupMySQL.sh SDPController/setup/

RUN echo "Starting Mysql service and setting up database..." 
RUN apt-get install -y mysql-server && service mysql start && mysql -u root -e "create database sdp;" && cd SDPController/setup && mysql -u root sdp < sdp.sql && \
    ./setupMySQL.sh

RUN apt-get install -y openssl && ./Gencert.sh

EXPOSE 5000
EXPOSE 22

CMD ["/bin/bash", "-c","/controller/runController.sh"]


