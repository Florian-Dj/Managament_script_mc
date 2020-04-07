# Management Server name

server=name
settings=~/settings/settings-name.ini
ram=$(awk -F"=" '/ram/ {print $2}' $settings)
port=$(awk -F"=" '/port/ {print $2}' $settings)


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
Management Server :  name
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

1 - Delete Server
2 - Look Settings
3 - Change Settings
0 - Back
"

read -p "Chosse action : " choose
case $choose in
    1)	delete;;
    2)	cat ~/settings/settings-name.ini
	sleep 2
	settings;;
    3)	vim ~/settings/settings-name.ini;;
    0)	mng_srv;;
esac
}

delete(){
read -p "Warning! This action will delete server. Are you sure ? (yes/no) : " choose
case $choose in
    yes)rm -rf /opt/minecraft/instances/name
	rm ~/instances/management-name.sh
	rm ~/settings/settings-name.ini
	;;
    no) settings
	;;
    *)	delete
	;;
esac
}


check
