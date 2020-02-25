#!/bin/bash

apt install wget java screen git -y
yum install wget java screen git -y
useradd minecraft --home /home/minecraft --shell /bin/bash
mkdir /home/minecraft/instances
chown -R minecraft: /home/minecraft
mkdir -p /opt/minecraft/instances
chown -R minecraft: /opt/minecraft
git clone https://github.com/Mucral/Managament_script_mc.git
