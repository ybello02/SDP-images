#!/bin/bash

#login as a root
echo "Cloning SDPController project from Waverley..."
git clone https://github.com/waverleylabs/SDPController.git
yes | cp -rf config.js SDPController/config.js 
cd SDPController
sudo npm install
#login to the database
echo "Starting Mysql service and setting up database..."
service mysql start
mysql -u root -e "create database sdp;"

#import the db to the controller
cd setup
mysql -u root sdp < sdp.sql


#EDIT the following config to match your SDP setup
#populate the tables
mysql sdp << EOF
INSERT INTO sdpid(sdpid,valid,type,country,state,locality,org,org_unit,alt_name,email,serial) VALUES (1,1,'gateway','CA', 'ON', 'London', 'UWO', 'SE', 'Postdoc', 'abc@xyz.com', 'abc123');
INSERT INTO sdpid(sdpid,valid,type,country,state,locality,org,org_unit,alt_name,email,serial)VALUES (2,1,'controller','CA', 'ON', 'London', 'UWO', 'SE', 'Postdoc', 'abc@xyz.com', 'abc123');
INSERT INTO sdpid(sdpid,valid,type,country,state,locality,org,org_unit,alt_name,email,serial)VALUES (3,1,'client','CA', 'ON', 'London', 'UWO', 'SE', 'Postdoc', 'abc@xyz.com', 'abc123');

INSERT INTO service VALUES(1,'controller', 'controller' );
INSERT INTO service VALUES(2,'tcp', 'tcp' );
INSERT INTO service VALUES(3,'udp', 'udp' );

INSERT INTO service_gateway (id,service_id, gateway_sdpid, protocol, port, nat_ip, nat_port) VALUES(1, 1, 1 ,'tcp',5000, 'controllerIP', 5000);
INSERT INTO service_gateway (id,service_id, gateway_sdpid, protocol, port, nat_ip, nat_port) VALUES(2, 2, 1 ,'tcp',4444, 'gatewayIP', 4444);
INSERT INTO sdpid_service VALUES (1, 1, 1);
#this means that the gateway has access to service 1
INSERT INTO sdpid_service VALUES (2, 1, 2);
INSERT INTO sdpid_service VALUES(3, 3, 1);
INSERT INTO sdpid_service VALUES(4, 3, 2);
EOF
