#!/bin/bash
sudo ifconfig eth0:3 10.0.0.1 
sudo pppoe-server -I eth0:3 -L 10.0.0.1 -R 10.0.0.2 -N 25
sudo iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o eth0 -j MASQUERADE
