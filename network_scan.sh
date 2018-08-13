#!/bin/bash

ifconfig > ifconfig_file
cat ifconfig_file | grep broadcast | cut -d" " -f10 | cut -d"." -f1-3 > ipnet1
echo "MAC Address: " > my_mac
cat ifconfig_file | grep ether | cut -d" " -f10 >> my_mac
my_ip=`cat ifconfig_file | grep broadcast | cut -d" " -f10`
cat ipnet1 | cut -f1-3 -d"." > t1; cat t1 | tr "\n" "." > t2
echo -n "0/24" >> t2
networkip=`cat t2`
ipnet2=`echo $networkip | tr / . | cut -d"." -f1-4`
echo "$ipnet2  Network ip"
echo "$my_ip Local ip"

nmap -sP $networkip > net_hosts
echo -e "\nHosts up on network \n"
cat net_hosts | grep report | cut -d" " -f5 > hosts_up
cat net_hosts | grep MAC > mac_address
cat net_hosts | grep scanned | cut -d" " -f3-12 >> hosts_up
cat my_mac | tr "\n" " " | tr -s " " >> mac_address
paste hosts_up mac_address

rm ifconfig_file ipnet1 t1 t2 net_hosts my_mac hosts_up mac_address
unset ipnet2 my_ip networkip
