# Management Server name

echo "Management Serveur name:

1 - Start
2 - Stop
3 - Restart
0 - Exit
"


<<COMMENT
cd /opt/minecraft/instances/name
/usr/bin/screen -dmS mc-srv-name /bin/bash mc-run.sh

ExecStop=/usr/bin/screen -p 0 -S mcserv-srv-test -X eval 'stuff "say SERVER SHUTTING DOWN. Saving map..."\\015'
ExecStop=/usr/bin/sleep 5
ExecStop=/usr/bin/screen -p 0 -S mcserv-srv-test -X eval 'stuff "save-all"\\015'
ExecStop=/usr/bin/screen -p 0 -S mcserv-srv-test -X eval 'stuff "stop"\\015'
ExecStop=/bin/sleep 2

[Install]
WantedBy=multi-user.target
COMMENT
