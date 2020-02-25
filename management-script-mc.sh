#!/bin/bash

spigot=(4 15)
craftbukkit=(0 15)
paper=(12 15)

# echo ${spigot[0]}
for i in `seq ${spigot[0]} ${spigot[1]}`;
do
	echo $i - 1.$i
done

# Choose Project Name
read -p 'Project Name: ' name

# Choose Bukkit (Spigot, Craftbukkit or Papermc)
choose_bukkit() {
echo """
Choose Bukkit :

1 - Spigot
2 - Craftbukkit
3 - Papermc

"""
read -p "Bukkit server: " bukkit
case $bukkit in
    1)	url="https://cdn.getbukkit.org/spigot/spigot-version.jar"
	choose_version
	;;
    2)	url="https://cdn.getbukkit.org/craftbukkit/craftbukkit-version.jar"
	choose_version
	;;
    3)	url="https://papermc.io/api/v1/paper/version/latest/download"
	choose_version
	;;
    *) choose_bukkit;;
esac
}

# Choose version minecraft server
choose_version() {
echo "Choose Version :"
for i in `seq ${spigot[0]} ${spigot[1]}`;
do
	echo $i - 1.$i
done
read -p 'Patch server: ' patch
case $patch in
    1) version="1.12.2";;
    2) version="1.13.2";;
    3) version="1.14.4";;
    4) version="1.15.2";;
    *) choose_version;;
esac
}

choose_bukkit

# Download java-server.jar
wget -O java-server.jar https://papermc.io/api/v1/paper/$version/latest/download
echo "Minecraft Server PaperMc $version Download !"

# Create folder minecraft and folder project name
mkdir /opt/minecraft/instances/$name

# Change owner and move java-server.jar
mv java-server.jar /opt/minecraft/instances/$name/java-server.jar

# Copy/Paste and change owner mc-run.sh
cp mc-run.sh /opt/minecraft/instances/$name/mc-run.sh

# Copy/Paste eula.txt
cp eula.txt /opt/minecraft/$name/eula.txt

# Copy/Pasten change variable and move minecraft.service
cp minecraft-template.service minecraft-"$name".service
sed -i "s/srv-name/$name/g" minecraft-"$name".service
mv minecraft-"$name".service /usr/lib/systemd/system/minecraft-"$name".service

#Change owner folder minecraft
chown -R minecraft: /opt/minecraft/
