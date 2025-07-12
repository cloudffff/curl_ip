#!/bin/bash

country=$(curl -s ifconfig.co/country)
echo "Server Location is: $country"
ip=$(curl -s ifconfig.co/)
echo "Server IP is: $ip"
