#!/bin/bash

export default_gw=$(echo $(ip route | grep default) | cut -d " " -f 3)
export iface_nic="mos_sec-pub"

## Create Base for our firewall
sudo nft "flush ruleset"
sudo nft "add table FILTER"
sudo nft "add chain FILTER INPUT { type filter hook input priority 0; policy accept; }"
sudo nft "add rule FILTER INPUT ct state established,related accept;"

## Enable IPV4 forwarding
sudo sysctl -q net.ipv4.ip_forward=1
sudo sysctl -q net.ipv6.conf.default.forwarding=0
sudo sysctl -q net.ipv6.conf.all.forwarding=0

## Grant net NAT access to our bridge interface
sudo nft "add table NAT"
sudo nft "add chain NAT PREROUTING { type nat hook prerouting priority -100; policy drop; }"
sudo nft "add chain NAT POSTROUTING { type nat hook postrouting priority 100 ; }"

sudo nft "add rule NAT PREROUTING iif" $iface_nic "accept;"
sudo nft "add rule NAT PREROUTING iif" $iface_nic "tcp dport { 80, 443 } dnat " $default_gw ";"
sudo nft "add rule NAT POSTROUTING masquerade;"
