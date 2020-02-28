#!/bin/bash

#Var for spigot, craftbukkit and paper version and under version
spigot=(4 15)
spigot_version=(7 2 4 10 8 4 2 2 2 2 4 2)
craftbukkit=(0 15)
craftbukkit_version=(0 1 5 2 7 2 4 10 8 4 2 2 2 2 4 2)
paper=(12 15)

# Choose Project Name
read -p 'Project Name: ' name

# Function choose Bukkit (Spigot, Craftbukkit or Papermc)
choose_bukkit() {
echo """
Choose Bukkit :

1 - Spigot
2 - Craftbukkit
3 - Papermc
4 - Other
"""

# Read for choose bukkit
read -p "Bukkit server: " choose
case $choose in
    #choose spigot
    1)	url="https://cdn.getbukkit.org/spigot/spigot-version.jar"
	bukkit="spigot"
        choose_version $bukkit
	;;
    #choose craftbukkit
    2)	url="https://cdn.getbukkit.org/craftbukkit/craftbukkit-version.jar"
	bukkit="craftbukkit"
        choose_version $bukkit
	;;
    #choose papermc
    3)	url="https://papermc.io/api/v1/paper/version/latest/download"
        bukkit="paper"
	choose_version $bukkit
	;;
    #choose other bukkit
    4)  read -p "Your Link java-server.jar: " link
	url=$link
	;;
    #reboot function choose Bukkit (Spigot, Craftbukkit or Papermc)
    *) choose_bukkit;;
esac
}

# Choose version minecraft server
choose_version() {
echo -e "Choose Version for $1: \n"

# While for version bukkit in list
tab=()
for i in `seq 1 $(($1[1]-$1[0]+1))`
do
     tab[$i]=$(($1[0]+$i-1))
done

# While for version bukkit echo
u=1
for i in `seq $(($1[0])) $(($1[1]))`
do
    #if bukkit different from paper echo under_version or not
    if [ $bukkit != "paper" ]
    then
        echo "$u - 1.${i}.$(($1_version[$u-1]))"
    else
        echo "$u - 1.${i}"
    fi
    ((u++))
done
echo "0 - Back"
echo -e

# Read for version bukkit
read -p 'Patch server: ' patch
#if patch>=1 and <=len(tab)
if [ 1 -le $patch ] && [ $patch -le ${#tab[*]} ]
then
    #if bukkit different from paper version=1.version.under_version or just 1.version
    if [ $bukkit != "paper" ]
    then
        version="1.${tab[$patch]}.$(($1_version[$patch-1]))"
    else
        version="1.${tab[$patch]}"
    fi
elif [ $patch == 0 ]
then
    #reboot choose version minecraft server
    choose_bukkit
else
    #back to function choose Bukkit (Spigot, Craftbukkit or Papermc)
    choose_version $1
fi
}

#Launch function choose_bukkit
choose_bukkit

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

# Copy/Pasten change variable and move minecraft.service
cp file-srv/minecraft-template.service file-srv/minecraft-"$name".service
sed -i "s/srv-name/$name/g" file-srv/minecraft-"$name".service
mv file-srv/minecraft-"$name".service /usr/lib/systemd/system/minecraft-"$name".service

#Change owner folder minecraft on /opt/minecraft and /home/minecraft
chown -R minecraft: /opt/minecraft/instances
chown -R minecraft: /home/minecraft/instances
