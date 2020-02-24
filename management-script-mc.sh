#!/bin/bash

# read -p "Name Project: " name
# useradd $name --home /home/$name --shell /bin/bash

read -p 'Project Name: ' name

choose_version () {
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
    *) choose_version;;
esac
}

choose_version

wget -O java-server.jar https://papermc.io/api/v1/paper/$version/latest/download
echo "Minecraft Server PaperMc $version Download !"

mkdir /opt/minecraft/
mkdir /opt/minecraft/$name/
chown minecraft: java-server.jar
mv java-server.jar /opt/minecraft/$name/java-server.jar

cp mc-run.sh /opt/minecraft/$name/mc-run.sh
chown minecraft: /opt/minecraft/$name/mc-run.sh

cp minecraft-template.service /usr/lib/systemd/system/minecraft-"$name".service
