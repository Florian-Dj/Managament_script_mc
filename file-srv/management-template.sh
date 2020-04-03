# Management Server name

server=name
ram=$(awk -F"=" '/name_ram/ {print $2}' settings.ini)
port=$(awk -F"=" '/name_port/ {print $2}' settings.ini)


check(){
if [ "$(whoami)" == "minecraft" ]
then
    mng_srv
else
    echo "Permision denied ! Connect to minecraft user !"
fi
}


mng_srv(){
echo "
Management Server
Server : name
Port : $port
Ram : $ram Mo
"

if ps aux | grep -v 'grep' | grep -q name
then
    echo "1 - Stop"
    echo "2 - Restart"
    echo "3 - Settings"
else
    echo "1 - Start"
    echo "2 - Settings"
fi

echo "0 - Exit"
echo ""

read -p "Choose action : " choose
if ps aux | grep -v 'grep' | grep -q name
then
    if [ $choose -eq 1 ]
    then
        cd /opt/minecraft/instances/name
        /usr/bin/screen -p 0 -S mc-srv-name -X eval 'stuff "say SERVER SHUTTING DOWN. Saving map..."\\015'
        /usr/bin/sleep 5
        /usr/bin/screen -p 0 -S mc-srv-name -X eval 'stuff "save-all"\\015'
        /usr/bin/screen -p 0 -S mc-srv-name -X eval 'stuff "stop"\\015'
        /bin/sleep 2
    elif [ $choose -eq 2 ]
    then
        cd /opt/minecraft/instances/name
        /usr/bin/screen -p 0 -S mc-srv-name -X eval 'stuff "say SERVER SHUTTING DOWN. Saving map..."\\015'
        /usr/bin/sleep 5
        /usr/bin/screen -p 0 -S mc-srv-name -X eval 'stuff "save-all"\\015'
        /usr/bin/screen -p 0 -S mc-srv-name -X eval 'stuff "stop"\\015'
        /bin/sleep 20
        /usr/bin/screen -dmS mc-srv-name /bin/bash mc-run.sh
    elif [ $choose -eq 3 ]
    then
        settings
    elif [ $choose -eq 0 ]
    then
        exit
    else
        mng_serv
    fi
else
    if [ $choose -eq 1 ]
    then
        cd /opt/minecraft/instances/name
        /usr/bin/screen -dmS mc-srv-name /bin/bash mc-run.sh
    elif [ $choose -eq 2 ]
    then
        settings
    elif [ $choose -eq 0 ]
    then
        exit
    else
        mng_serv
    fi
fi
}


settings(){
echo "Setting for Serveur name:

1 - Delete
2 - Ram
0 - Back
"

read -p "Chosse action : " choose
case $choose in
    1)	delete
	;;
    2)	ram
	;;
    0)	mng_srv
	;;
esac
}

delete(){
read -p "Warning! This action will delete server. Are you sure ? (yes/no) : " choose
case $choose in
    yes)rm -rf /opt/minecraft/instances/name
	rm ~/instances/management-name.sh
	sed -i '/name/d' ~/instances/settings.ini
	sed -i '/ /d' ~/instances/settings.ini
	;;
    no) settings
	;;
    *)	delete
	;;
esac
}

ram(){
    echo "Allocated ram server : $ram"
}

check
