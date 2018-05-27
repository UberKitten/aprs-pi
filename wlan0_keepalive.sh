#!/bin/bash

# Get gateway IP for wlan0 interface
# We don't care if internet goes down, only if WLAN connection goes down
gateway_ip=$(/sbin/ip route |grep '^default' | awk '/wlan0/ {print $3}')

# Ping check
ping -c2 ${gateway_ip} > /dev/null

# Restart wlan0 if fail
if [ $? != 0 ]
then
    sudo ifdown --force wlan0
    sudo ifup wlan0
fi