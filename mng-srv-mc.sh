#!/bin/bash

# Check pull request http
request_https() {
echo $1
request_cmd="$(curl -i -o - --silent -X GET --header 'Accept: application/json' --header 'Authorization: _your_auth_code==' $1)"
http_status=$(echo "$request_cmd" | grep HTTP |  awk '{print $2}')
if [ $http_status == "200" ]
then
    echo "Ok"
else
    echo "Error, server web not found"
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

read -p 'Chosse Bukkit Support: ' bukkit
case $bukkit in
    1)	url="https://getbukkit.org/download/spigot"
	request_https $url;;
    2)	url="https://getbukkit.org/download/craftbukkit"
	request_https $url;;
    3)	url="https://papermc.io/ci/rssLatest"
	request_https $url;;
    4)	url="https://getbukkit.org/download/vanilla"
	request_https $url;;
    5)  read -p "Your link: " $link_other
	request_https $url;;
    *)	bukkit_support;;
esac
}

# Choose Project Name
choose_name_server() {
read -p 'Project Name: ' name_server
if [ -z $name_server ]
then
    echo -e "Enter name server!"
    choose_name_server
else
    bukkit_support
fi
}

if [ -z $1 ]
then
    choose_name_server
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
