![Platform](https://img.shields.io/conda/pn/conda-forge/bash?color=green&style=plastic&logo=linux)
![Repo Size](https://img.shields.io/github/repo-size/Mucral/Managament_script_mc?color=yellow&logo=github&style=plastic)
![Langage](https://img.shields.io/github/languages/top/mucral/Managament_script_mc?style=plastic)

[![Discord](https://img.shields.io/discord/252008610043789312?logo=discord&label=discord&color=7289da&style=plastic)](https://discordapp.com/channels/252008610043789312)
[![Twitch](https://img.shields.io/twitch/status/mucral_tv?logo=twitch&color=9147ff&style=plastic)](https://www.twitch.tv/mucral_tv)
[![Twitter](https://img.shields.io/twitter/follow/mucral?color=1da1f2&label=twitter&logo=twitter&style=plastic)](https://twitter.com/Mucral)

# Management Server Minecraft
Install and management multiple Minecraft server on VM, VPS, Dedicated

## Requirement
- Harware (minimal) :
-- 2 vCore
-- 2 Go of ram

- Software :
-- Java runtime environment
-- Screen
-- Curl
-- Git

Debian Family :
```
$ apt install curl java screen git -y
```
Red Hat Family :
```
$ yum install curl java screen git -y
```

## Getting Started
### Command on root
```
$ useradd minecraft --home /home/minecraft --shell /bin/bash
$ passwd minecraft (enter password user)
$ mkdir -p /opt/minecraft/instances
$ chown -R minecraft: /opt/minecraft
```

### Command on user servcie minecraft
```
$ su - minecraft
$ mkdir ~/instances
$ git clone https://github.com/Mucral/Managament_script_mc.git management
```

## How to start 
```
cd ~/management
./mng-srv-mc.sh
```
Then choose bukkit support and version

## How to start/stop/restart server
```
$ cd ~/instances
$ ./management-nameproject.sh
```
Then select the desired action on the server

## Where to find server files
```
$ cd /opt/minecraft/instances/nameproject
```
You will find all the server files, plugins, options, maps
