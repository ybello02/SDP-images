#!/usr/bin/env bash

echo "Copying config files..."
yes Y  | sudo cp access.conf /etc/fwknop/
yes Y  | sudo cp fwknopd.conf /etc/fwknop/
yes Y  | sudo cp gate_sdp_ctrl_client.conf /etc/fwknop/
yes Y  | sudo cp gate.fwknoprc /etc/fwknop/

while true; do
    sleep 100
done
