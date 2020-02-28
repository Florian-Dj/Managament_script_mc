# Management Server name

mng_srv(){
echo "Management Serveur name:

1 - Start
2 - Stop
3 - Restart
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
    0)  exit
	;;
    *)  mng_srv;;
esac
}
mng_srv
