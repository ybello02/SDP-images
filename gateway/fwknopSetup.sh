#!/usr/bin/env bash

echo "Copying config files..."
yes Y  | cp access.conf /etc/fwknop/
yes Y  | cp fwknopd.conf /etc/fwknop/
yes Y  | cp gate_sdp_ctrl_client.conf /etc/fwknop/
yes Y  | cp gate.fwknoprc /etc/fwknop/

while true; do
    sleep 100
done
