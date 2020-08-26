FROM ubuntu:16.04

WORKDIR /App
COPY * /App/

ARG SSH_PASS=eceUser 

RUN apt-get update -y && apt-get install -y openssh-server 

# RUN mkdir /var/run/sshd

RUN useradd -m -s /bin/bash -p $(openssl passwd -1 $SSH_PASS) sshuser && usermod -aG sudo sshuser

EXPOSE 22
RUN chmod -R 755 start.sh
# CMD service ssh start && /bin/bash
CMD ["/bin/bash","-c", "./start.sh"]

