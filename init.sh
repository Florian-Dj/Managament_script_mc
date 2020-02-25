#!/bin/bash

apt install wget java screen -y
yum install wget java screen -y
useradd minecraft --home /home/minecraft --shell /bin/bash
mkdir /home/minecraft/instances
chown -R minecraft: /home/minecraft
mkdir -p /opt/minecraft/instances
chown -R minecraft: /opt/minecraft
