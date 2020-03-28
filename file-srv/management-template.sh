# Management Server name


check(){
if [ "$(whoami)" == "minecraft" ]
then
    mng_srv
else
    echo "Permision denied ! Connect to minecraft user !"
fi
}


mng_srv(){
echo "Management Serveur name:

1 - Start
2 - Stop
3 - Restart
4 - Settings
0 - Exit
"

read -p "Choose action : " choose
case $choose in
    1)  cd /opt/minecraft/instances/name
	/usr/bin/screen -dmS mc-srv-name /bin/bash mc-run.sh
        ;;
    2)  cd /opt/minecraft/instances/name
	/usr/bin/screen -p 0 -S mc-srv-name -X eval 'stuff "say SERVER SHUTTING DOWN. Saving map..."\\015'
	/usr/bin/sleep 5
	/usr/bin/screen -p 0 -S mc-srv-name -X eval 'stuff "save-all"\\015'
	/usr/bin/screen -p 0 -S mc-srv-name -X eval 'stuff "stop"\\015'
	/bin/sleep 2
	;;
    3)  cd /opt/minecraft/instances/name
	/usr/bin/screen -p 0 -S mc-srv-name -X eval 'stuff "say SERVER SHUTTING DOWN. Saving map..."\\015'
	/usr/bin/sleep 5
	/usr/bin/screen -p 0 -S mc-srv-name -X eval 'stuff "save-all"\\015'
	/usr/bin/screen -p 0 -S mc-srv-name -X eval 'stuff "stop"\\015'
	/bin/sleep 20
        /usr/bin/screen -dmS mc-srv-name /bin/bash mc-run.sh
        ;;
    4)	settings
	;;
    0)  exit
	;;
    *)  mng_srv;;
esac
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
    2)	echo "Ram"
	;;
    0)	mng_srv
	;;
esac
}

delete(){
read -p "Warning! This action will delete server. Are you sure ? (yes/no) " choose
case $choose in
    yes)rm -rf /opt/minecraft/instances/name
	rm ~/instances/management-name.sh;;
    no) settings
	;;
    *)	delete
	;;
esac
}

check
