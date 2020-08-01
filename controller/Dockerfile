FROM ubuntu:14.04

WORKDIR /controller
COPY * /controller/

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN echo "Doing intial setup..."

RUN apt-get update -y && apt-get install -y curl git
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

RUN echo "Cloning SDPController project from Waverley..."
RUN git clone https://github.com/waverleylabs/SDPController.git
RUN yes | cp -rf config.js SDPController/config.js 
WORKDIR SDPController
RUN npm install

RUN echo "Starting Mysql service and setting up database..."
RUN apt-get install -y mysql-server && service mysql start && mysql -u root -e "create database sdp;" && WORKDIR setup && mysql -u root sdp < sdp.sql && \
    mysql sdp << EOF && \
    INSERT INTO sdpid(sdpid,valid,type,country,state,locality,org,org_unit,alt_name,email,serial) VALUES (1,1,'gateway','CA', 'ON', 'London', 'UWO', 'SE', 'Postdoc', 'abc@xyz.com', 'abc123'); && \
    INSERT INTO sdpid(sdpid,valid,type,country,state,locality,org,org_unit,alt_name,email,serial)VALUES (2,1,'controller','CA', 'ON', 'London', 'UWO', 'SE', 'Postdoc', 'abc@xyz.com', 'abc123'); && \
    INSERT INTO sdpid(sdpid,valid,type,country,state,locality,org,org_unit,alt_name,email,serial)VALUES (3,1,'client','CA', 'ON', 'London', 'UWO', 'SE', 'Postdoc', 'abc@xyz.com', 'abc123');  && \
    INSERT INTO service VALUES(1,'controller', 'controller' ); && \
    INSERT INTO service VALUES(2,'tcp', 'tcp' ); && \
    INSERT INTO service VALUES(3,'udp', 'udp' ); && \
    INSERT INTO service_gateway (id,service_id, gateway_sdpid, protocol, port, nat_ip, nat_port) VALUES(1, 1, 1 ,'tcp',5000, 'controllerIP', 5000); && \
    INSERT INTO service_gateway (id,service_id, gateway_sdpid, protocol, port, nat_ip, nat_port) VALUES(2, 2, 1 ,'tcp',4444, 'gatewayIP', 4444); && \
    INSERT INTO sdpid_service VALUES (1, 1, 1); && \
    INSERT INTO sdpid_service VALUES (2, 1, 2);  && \
    INSERT INTO sdpid_service VALUES(3, 3, 1);  && \
    INSERT INTO sdpid_service VALUES(4, 3, 2);  && \
    EOF

WORKDIR /controller
RUN apt-get install -y openssl && country=CA && state=ON && locality=London && organization=UWO && organizationalunit=SE && email=abc@xyz.com && \
    password=controller && \
    sdpComponentCount=3 && echo "Generating Root Cert.." && openssl genrsa -des3 -passout pass:$password -out ca.key 4096 && openssl req -new -x509 -days 365 -key ca.key -out ca.crt -passin pass:$password \
    -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email" &&  sh -x && \
    for i in {1..$sdpComponentCount} \
    do \
    echo "Generating credential $i ... " \
    node ./SDPController/genCredentials.js $1 \
    done

WORKDIR /controller
EXPOSE 5000
EXPOSE 22

CMD ["/bin/bash", "-c","/controller/runController.sh"]


