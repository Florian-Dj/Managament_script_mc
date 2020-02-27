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
	echo "$u - 1.${i}.$(($1_version[$u-1]))"
	((u++))
done
echo "0 - Back"
echo -e

tab=()
for i in `seq 1 $(($1[1]-$1[0]+1))`
do
     tab[$i]=$(($1[0]+$i-1))
done
}
choose_bukkit
<<COMMENT
read -p 'Patch server: ' patch
if [ 1 -le $patch ] && [ $patch -le ${#tab[*]} ]
then
    if [ $bukkit != "paper"  ]
    then
        version="1.${tab[$patch]}."
    else
        version="1.${tab[$patch]}"
    fi
elif [ $patch == 0 ]
then
    choose_bukkit
else
    choose_version $1
fi
}

#Launch function choose_bukkit
choose_bukkit

echo "Minecraft Server $name $version Download on /opt/minecraft/instances/$name !"

# Create folder projet on /opt
mkdir /opt/minecraft/instances/$name

# Download java-server.jar and move
url=${url/version/$version}
wget -O java-server.jar $url
mv java-server.jar /opt/minecraft/instances/$name/java-server.jar
echo "Minecraft Server $bukkit $version Download on /opt/minecraft/instances/$name !"

# Copy/Paste, mc-run.sh and eula.txt
cp file-mc/mc-run.sh /opt/minecraft/instances/$name/mc-run.sh
cp file-mc/eula.txt /opt/minecraft/instances/$name/eula.txt

# Copy/Pasten change variable and move minecraft.service
cp file-mc/minecraft-template.service file-mc/minecraft-"$name".service
sed -i "s/srv-name/$name/g" file-mc/minecraft-"$name".service
mv file-mc/minecraft-"$name".service /usr/lib/systemd/system/minecraft-"$name".service

#Change owner folder minecraft
chown -R minecraft: /opt/minecraft/
chown -R minecraft: /home/minecraft/
COMMENT

