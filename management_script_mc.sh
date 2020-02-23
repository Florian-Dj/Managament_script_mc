#!/bin/bash

echo """
Choose Version :

1 - 1.12
2 - 1.13
3 - 1.14
4 - 1.15

"""
read -p 'Patch server: ' choose
case $choose in
    1) version="1.12.2";;
    2) version="1.13.2";;
    3) version="1.14.4";;
    4) version="1.15.2";;
    *) version="Rien";;
esac
wget -O java_server.jar https://papermc.io/api/v1/paper/$version/latest/download
