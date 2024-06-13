#!/bin/bash
ip link del dev eth0.10
ip link add link eth0 name eth0.10 type vlan id 10
ip addr add 192.168.10.5/32 dev eth0.10
ip link set eth0.10 up
