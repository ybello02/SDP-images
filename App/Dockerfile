FROM ubuntu:18.04

ARG SSH_PASS=eceUser 

RUN apt-get update -y && apt-get install -y openssh-server

RUN useradd -m -s /bin/bash -p $(openssl passwd -1 $SSH_PASS) sshuser

EXPOSE 22

CMD systemctl start ssh && /bin/bash
