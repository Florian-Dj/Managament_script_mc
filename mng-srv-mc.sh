#!/bin/bash

# Choose Project Name
read -p 'Project Name: ' name

echo "Minecraft Server $name $bukkit $version Download on /opt/minecraft/instances/$name !"

# Create folder projet on /opt
mkdir /opt/minecraft/instances/$name

# Download java-server.jar and move
url=${url/version/$version}
wget -O java-server.jar $url
mv java-server.jar /opt/minecraft/instances/$name/java-server.jar
echo "Minecraft Server $bukkit $version Download on /opt/minecraft/instances/$name !"

# Copy/Paste, mc-run.sh and eula.txt
cp file-srv/mc-run.sh /opt/minecraft/instances/$name/mc-run.sh
cp file-srv/eula.txt /opt/minecraft/instances/$name/eula.txt

# Copy/Paste management-template.sh
cp file-srv/management-template.sh file-srv/management-"$name".sh
sed -i "s/name/$name/g" file-srv/management-"$name".sh
mv file-srv/management-"$name".sh /home/minecraft/instances/management-"$name".sh
