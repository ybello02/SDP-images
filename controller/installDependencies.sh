#!/usr/bin/env bash
echo "Doing intial setup..."
sudo apt-get update -y
sudo apt-get install -y curl git mysql-server openssl openssh-server
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Dependencies installed!"