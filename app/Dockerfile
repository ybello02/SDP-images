
FROM ubuntu:16.04

WORKDIR /App
COPY * /App/

ARG SSH_PASS=eceUser 

RUN apt-get update -y && apt-get install -y openssh-server sudo net-tools

RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd

RUN useradd -m -s /bin/bash -p $(openssl passwd -1 $SSH_PASS) sshuser && usermod -aG sudo sshuser
# RUN chmod -R 0755 /etc/ssh
EXPOSE 22
RUN chmod -R 755 /App/start.sh && /App/start.sh
# CMD chmod -R 0755 /etc/ssh && service ssh start && /bin/bash
CMD ["/usr/sbin/sshd","-D"]
