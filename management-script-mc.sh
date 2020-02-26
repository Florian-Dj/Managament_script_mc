#!/bin/bash

spigot=(4 15)
spigot_version=(7 2 4 10 8 4 2 2 2 2 4 2)
craftbukkit=(0 15)
craftbukkit_version=(0 1 5 2 7 2 4 10 8 4 2 2 2 2 4 2)
paper=(12 15)
url=""

# Choose Project Name
read -p 'Project Name: ' name

# Choose Bukkit (Spigot, Craftbukkit or Papermc)
choose_bukkit() {
echo """
Choose Bukkit :

1 - Spigot
2 - Craftbukkit
3 - Papermc
4 - Other
"""

read -p "Bukkit server: " bukkit
case $bukkit in
    1)	url="https://cdn.getbukkit.org/spigot/spigot-version.jar"
	choose_version "spigot"
	;;
    2)	url="https://cdn.getbukkit.org/craftbukkit/craftbukkit-version.jar"
	choose_version "craftbukkit"
	;;
    3)	url="https://papermc.io/api/v1/paper/version/latest/download"
	choose_version "paper"
	;;
    4)  read -p "Your Link java-server.jar: " link
	url=$link
	;;
    *) choose_bukkit;;
esac
}

# Choose version minecraft server
choose_version() {
echo -e "Choose Version for $1: \n"

u=1
for i in `seq $(($1[0])) $(($1[1]))`
do
	echo $u - 1.$i
	((u++))
done
echo -e "\n"

tab=()
for i in `seq 1 $(($1[1]))`
do
     tab[$i]=$i
done

read -p 'Patch server: ' patch
if [[ " ${tab[*]} " =~ .*\ $patch\ .* ]]
then
    version="1.$patch"
else
    choose_version $1
fi
}

#Launch function choose_bukkit
choose_bukkit

# Create folder projet, opt and home
mkdir /opt/minecraft/instances/$name
mkdir /home/minecraft/instances/$name

# Download java-server.jar and move
wget -O java-server.jar $url=${url//version/$version}
mv java-server.jar /opt/minecraft/instances/$name/java-server.jar
echo "Minecraft Server $bukkit $version Download on /opt/minecraft/instances/$name !"

# Copy/Paste, mc-run.sh and eula.txt
cp mc-run.sh /opt/minecraft/instances/$name/mc-run.sh
cp eula.txt /opt/minecraft/instances/$name/eula.txt

# Copy/Pasten change variable and move minecraft.service
cp minecraft-template.service minecraft-"$name".service
sed -i "s/srv-name/$name/g" minecraft-"$name".service
mv minecraft-"$name".service /usr/lib/systemd/system/minecraft-"$name".service

#Change owner folder minecraft
chown -R minecraft: /opt/minecraft/
chown -R minecraft: /home/minecraft/
