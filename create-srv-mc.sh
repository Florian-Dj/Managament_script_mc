#!/bin/bash

name=""			#set name variable
version=""		#set version variable
url_request=""		#set for url request bukkit version
url_download=""		#set url download version bukkit support
bukkit=""		#set bukkit support (spigot, crafbukkit, paper, vanilla)
table_version_bukkit=""	#set all version for support
bukkit_version=()	#set list all version
bukkit_under_version=()	#set list all under_version



# Check setting is set to launch script
check() {
if [ -z $1 ]
then
  if [ "$(whoami)" == "minecraft" ]
  then
    choose_name_server
  else
    echo "Permision denied ! Connect to minecraft user !"
    exit
  fi
else
    echo "No settings! Delete $1"
    exit
fi
}


# Choose Project Name
choose_name_server() {
read -p 'Project Name: ' name_server
if [ -z $name_server ]
then
    echo -e "Enter name server!"
    choose_name_server
else
    name="$(echo $name_server | tr  [A-Z] [a-z])"
    bukkit_support
fi
}


# Check if download page is good
download_request(){
if [ $bukkit != "papermc" ] && [ $bukkit != "other" ]
then
    url_download="https://cdn.getbukkit.org/$bukkit/$bukkit-$version.jar"
elif [ $bukkit == "papermc" ]
then
    url_download="https://papermc.io/api/v1/paper/$version/latest/download"
fi
request_url="$(curl -i -o - --silent -X GET $url_download)"
http_status=$(echo "$request_url" | grep HTTP |  awk '{print $2}')
if [ $http_status == "200" ]
then
    server_script
fi
}

# Echo under_version for bukkit support
choose_version(){
number_choose=1
for versions in ${bukkit_under_version[*]}
do
    echo "$number_choose - $versions"
    ((number_choose++))
done
echo "0 - Back"

read -p "Choose version $bukkit support: " choose
if [ $choose -ge 1 ] && [ $choose -le ${#bukkit_under_version[*]} ]
then
    version=${bukkit_under_version[$choose-1]}
    download_request
elif [ $choose -eq 0 ]
then
    bukkit_support
else
    choose_version
fi
}


# List all version and all under_version
list_version(){
bukkit_version=()	#set list all version
bukkit_under_version=()	#set list all under_version
for version_list in $table_version_bukkit
do
    under_version=$(echo "$version_list" | grep -oP '1\.\d+')
    if ! [[ ${bukkit_version[*]} =~ (^|[[:space:]])"$under_version"($|[[:space:]]) ]]
    then
	bukkit_under_version=("${bukkit_under_version[@]}" $version_list)
	bukkit_version=("${bukkit_version[@]}" $under_version)
    fi
done
choose_version
}


# Check pull request http
request_https() {
request_url="$(curl -i -o - --silent -X GET $url_request)"
http_status=$(echo "$request_url" | grep HTTP |  awk '{print $2}')
if [ $http_status == "200" ]
then
    if [ $bukkit != "papermc" ]
    then
	table_version_bukkit="$(echo "$request_url" | grep -oP '<h2>1\.\d+\.\d+' | cut -c5-11)"
    else
	table_version_bukkit="$(echo "$request_url" | grep -oP '1\.\d+\.\d+')"
    fi
    list_version
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

read -p 'Choose Bukkit Support: ' number_bukkit
case $number_bukkit in
    1)	url_request="https://getbukkit.org/download/spigot"
	bukkit="spigot"
	request_https;;
    2)	url_request="https://getbukkit.org/download/craftbukkit"
	bukkit=""craftbukkit
	request_https;;
    3)	url_request="https://papermc.io/ci/rssLatest"
	bukkit="papermc"
	request_https;;
    4)	url_request="https://getbukkit.org/download/vanilla"
	bukkit="vanilla"
	request_https;;
    5)  read -p "Your link: " $url_request
	bukkit="other"
	request_https;;
    *)	bukkit_support;;
esac
}


server_script(){
echo "Minecraft Server $name $bukkit $version Download on /opt/minecraft/instances/$name !"
# Create folder projet on /opt
mkdir /opt/minecraft/instances/$name
# Download java-server.jar and move
curl -o java-server.jar $url_download
mv java-server.jar /opt/minecraft/instances/$name/java-server.jar
echo "Minecraft Server $bukkit $version Download on /opt/minecraft/instances/$name !"
# Copy/Paste, mc-run.sh and eula.txt
cp file-srv/mc-run.sh /opt/minecraft/instances/$name/mc-run.sh
cp file-srv/eula.txt /opt/minecraft/instances/$name/eula.txt
# Copy/Paste management-template.sh
cp file-srv/management-template.sh file-srv/management-"$name".sh
sed -i "s/name/$name/g" file-srv/management-"$name".sh
mv file-srv/management-"$name".sh /home/minecraft/instances/management-"$name".sh
}

check