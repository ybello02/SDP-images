#!/usr/bin/env bash

echo $sdpNetwork
service mysql start
sudo node ./SDPController/sdpController.js 
