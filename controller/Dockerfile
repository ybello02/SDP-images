FROM ubuntu:16.04

WORKDIR /controller
COPY * /controller/

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN echo "Doing intial setup..."

RUN apt-get update -y
RUN apt-get install -y curl git
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

RUN echo "Cloning SDPController project from Waverley..."
RUN git clone https://github.com/waverleylabs/SDPController.git
RUN yes | cp -rf config.js SDPController/config.js 
RUN cd SDPController
RUN npm install

RUN echo "Starting Mysql service and setting up database..."
RUN apt-get install -y mysql-server
# RUN service mysql start
RUN mysql -u root -e "create database sdp;"
RUN cd setup
RUN mysql -u root sdp < sdp.sql

RUN mysql sdp << EOF
RUN INSERT INTO sdpid(sdpid,valid,type,country,state,locality,org,org_unit,alt_name,email,serial) VALUES (1,1,'gateway','CA', 'ON', 'London', 'UWO', 'SE', 'Postdoc', 'abc@xyz.com', 'abc123');
RUN INSERT INTO sdpid(sdpid,valid,type,country,state,locality,org,org_unit,alt_name,email,serial)VALUES (2,1,'controller','CA', 'ON', 'London', 'UWO', 'SE', 'Postdoc', 'abc@xyz.com', 'abc123');
RUN INSERT INTO sdpid(sdpid,valid,type,country,state,locality,org,org_unit,alt_name,email,serial)VALUES (3,1,'client','CA', 'ON', 'London', 'UWO', 'SE', 'Postdoc', 'abc@xyz.com', 'abc123');

RUN INSERT INTO service VALUES(1,'controller', 'controller' );
RUN INSERT INTO service VALUES(2,'tcp', 'tcp' );
RUN INSERT INTO service VALUES(3,'udp', 'udp' );

RUN INSERT INTO service_gateway (id,service_id, gateway_sdpid, protocol, port, nat_ip, nat_port) VALUES(1, 1, 1 ,'tcp',5000, 'controllerIP', 5000);
RUN INSERT INTO service_gateway (id,service_id, gateway_sdpid, protocol, port, nat_ip, nat_port) VALUES(2, 2, 1 ,'tcp',4444, 'gatewayIP', 4444);
RUN INSERT INTO sdpid_service VALUES (1, 1, 1);

# this means that the gateway has access to service 1
RUN INSERT INTO sdpid_service VALUES (2, 1, 2);
RUN INSERT INTO sdpid_service VALUES(3, 3, 1);
RUN INSERT INTO sdpid_service VALUES(4, 3, 2);
RUN EOF

RUN apt-get install -y openssl
RUN country=CA
RUN state=ON
RUN locality=London
RUN organization=UWO
RUN organizationalunit=SE
RUN email=abc@xyz.com
RUN password=controller

RUN sdpComponentCount=3
RUN echo "Generating Root Cert.."
RUN openssl genrsa -des3 -passout pass:$password -out ca.key 4096
RUN openssl req -new -x509 -days 365 -key ca.key -out ca.crt -passin pass:$password \
    -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"

RUN for i in {1..$sdpComponentCount}
RUN do
RUN   echo "Generating credential $i ... "
RUN   node ./SDPController/genCredentials.js $1
RUN done

EXPOSE 5000
EXPOSE 22
# WORKDIR /controller
#  COPY * /controller/
# RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
# RUN ./installDependencies.sh
# RUN ./setupMySQL.sh
# RUN ./Gencerts.sh
CMD ["/bin/bash", "-c","/controller/runController.sh"]


