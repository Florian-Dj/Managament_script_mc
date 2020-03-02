#!/bin/bash

request_http() {
request_cmd="$(curl -i -o - --silent -X GET --header 'Accept: application/json' --header 'Authorization: _your_auth_code==' 'https://papermc.io/legacy')"
http_status=$(echo "$request_cmd" | grep HTTP |  awk '{print $2}')
if [ $http_status == "200" ]
then
    echo "Ok"
else
    echo "Error, server Web not found"
fi
}

# Choose bukkit support
bukkit_support() {
echo '
Bukkit Support :
1 - Spigot
2 - Craftbukkit
3 - Papermc
4 - Vanilla
5 - Other
'
}

# Choose Project Name
name_server() {
read -p 'Project Name: ' name
if [ -z $name ]
then
    echo -e "Enter name server!"
    name_server
else
    bukkit_support
fi
}

if [ -z $1 ]
then
    name_server
else
    echo "No settings! Delete $1"
    exit
fi

<< COMMENT
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
COMMENT
