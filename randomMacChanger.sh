#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"

if [[ $UID = 0 ]]; then
    if [[ -f $(which macchanger) ]]; then
        macchanger -l > vendormac.txt
        ouimac=$(shuf -n 1 vendormac.txt | awk '{print$3}')
        uaama=$(printf '%02x:%02x:%02x' $[Random%256] $[Random%256] $[Random%256])
        read -p "Enter your network interface : " IMAC
        ifconfig $IMAC down
        macchanger -m "$ouimac:$uaama" $IMAC
        ifconfig $IMAC up
        rm -rf vendormac.txt
    else
        echo "Macchanger not found "
        read -p "Do you want to install (y/N) " SELECT
        if [[ $SELECT == y || $SELECT == Y || $SELECT == Yes || $SELECT == yes || $SELECT == YES ]]; then
            apt install -y macchanger
        elif [[ $SELECT == n || $SELECT == N || $SELECT == no || $SELECT == No ]]; then
            printf "${GREEN}exit..."
        else
            printf "${GREEN}exit"
        fi
    fi
else
    echo -e "${RED}run as root"
fi
