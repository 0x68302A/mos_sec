#!/bin/bash

export default_gw=$(echo $(ip route | grep default) | cut -d " " -f 3)
export net_iface=$(/sbin/route | grep '^default' | grep -o '[^ ]*$')

export iface_pub_nic="mos_sec-pub"
export iface_priv_nic="mos_sec-priv"

## Create filter base for our firewall
sudo nft "flush ruleset"
sudo nft "add table mos_sec-filter"
sudo nft "add chain mos_sec-filter mos_input { type filter hook input priority 0; policy drop; }"
sudo nft "add rule mos_sec-filter mos_input ct state established,related accept;"
sudo nft "add rule mos_sec-filter mos_input iif " $net_iface " accept;"

## Enable IPV4 forwarding on host
sudo sysctl -q net.ipv4.ip_forward=1
sudo sysctl -q net.ipv6.conf.default.forwarding=0
sudo sysctl -q net.ipv6.conf.all.forwarding=0

## Grant net NAT access to our net-access bridge interface
sudo nft "add table mos_sec-pub-nat"
sudo nft "add chain mos_sec-pub-nat mos_prerouting { type nat hook prerouting priority -100; policy drop; }"
sudo nft "add rule mos_sec-pub-nat mos_prerouting iif" $iface_pub_nic "accept;"
sudo nft "add rule mos_sec-pub-nat mos_prerouting iif" $iface_pub_nic "tcp dport { 80, 443 } dnat " $default_gw ";"

sudo nft "add chain mos_sec-pub-nat mos_postrouting { type nat hook postrouting priority 100 ; }"
sudo nft "add rule mos_sec-pub-nat mos_postrouting masquerade;"

## Isolate private bridge
sudo nft "add table mos_sec-priv"
sudo nft "add chain mos_sec-priv mos_input { type filter hook input priority 50; policy drop; } "

sudo nft "add rule mos_sec-priv mos_input ct state established,related accept;"
sudo nft "add rule mos_sec-priv mos_input iifname " $iface_priv_nic " accept;"

## Accept inter-vm connections
sudo nft "add rule mos_sec-priv mos_input ip daddr 192.168.166.0/24 accept;"
sudo nft "add rule mos_sec-priv mos_input ip daddr 192.168.166.1 drop;"

## Accept SSH related connections from host
sudo nft "add rule mos_sec-priv mos_input iifname" $iface_priv_nic "tcp dport 2022 accept;"
