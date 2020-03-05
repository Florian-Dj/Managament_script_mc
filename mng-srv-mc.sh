#!/bin/bash

url=""			#var for url check
bukkit=""		#var bukkit support (spigot, crafbukkit, paper, vanilla)
table_version_bukkit=""	#all version for support


# Function echo all version bukkit support
choose_version(){
number=1
for version in $table_version_bukkit
do
   echo "$number - $version"
   ((number++))
done
}


# Check pull request http
request_https() {
request_cmd="$(curl -i -o - --silent -X GET --header 'Accept: application/json' --header 'Authorization: _your_auth_code==' $url)"
http_status=$(echo "$request_cmd" | grep HTTP |  awk '{print $2}')
if [ $http_status == "200" ]
then
    if [ $bukkit != "papermc" ]
    then
	table_version_bukkit="$(echo "$request_cmd" | grep -oP '<h2>1\.\d+\.\d+' | cut -c5-11)"
    else
	table_version_bukkit="$(echo "$request_cmd" | grep -oP '1\.\d+\.\d+')"
    fi
    choose_version
else
    echo "Error $http_status, server web not found"
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

read -p 'Chosse Bukkit Support: ' number_bukkit
case $number_bukkit in
    1)	url="https://getbukkit.org/download/spigot"
	bukkit="spigot"
	request_https;;
    2)	url="https://getbukkit.org/download/craftbukkit"
	bukkit=""craftbukkit
	request_https;;
    3)	url="https://papermc.io/ci/rssLatest"
	bukkit="papermc"
	request_https;;
    4)	url="https://getbukkit.org/download/vanilla"
	bukkit="vanilla"
	request_https;;
    5)  read -p "Your link: " $url
	request_https;;
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
