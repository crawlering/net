#!/bin/sh
ifconfig eth0 192.168.0.178 
ifconfig eth0:1 192.168.120.1
ifconfig eth0:2 192.168.150.1
route add default gw 192.168.0.1
ufw disable
sysctl -w net.ipv4.ip_forward=1

#route add -net 192.168.120.0/24 dev eth1
#iptables -t filter -A INPUT -s 192.168.120.0/24 -d 192.168.150.0/24 -j DROP
#iptables -t filter -A INPUT -s 192.168.150.0/24 -d 192.168.120.0/24 -j DROP
iptables -t filter -A FORWARD -s 192.168.120.0/24 -d 192.168.150.0/24 -j REJECT #reject 120.0/24 and 150.0/24 data exchange
iptables -t nat -A POSTROUTING -s 192.168.120.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.150.0/24 -o eth0 -j MASQUERADE
#iptables -t filter -A OUTPUT -s 192.168.120.0/24 -d 192.168.150.0/24 -j REJECT
#iptables -t filter -A OUTPUT -s 192.168.150.0/24 -d 192.168.120.0/24 -j REJECT

