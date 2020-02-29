![Platform](https://img.shields.io/conda/pn/conda-forge/bash?color=green&style=plastic&logo=linux)
![Repo Size](https://img.shields.io/github/repo-size/Mucral/Managament_script_mc?color=yellow&logo=github&style=plastic)
![Langage](https://img.shields.io/github/languages/top/mucral/Managament_script_mc?style=plastic)

[![Discord](https://img.shields.io/discord/252008610043789312?logo=discord&label=discord&color=7289da&style=plastic)](https://discordapp.com/channels/252008610043789312)
[![Twitch](https://img.shields.io/twitch/status/mucral_tv?logo=twitch&color=9147ff&style=plastic)](https://www.twitch.tv/mucral_tv)
[![Twitter](https://img.shields.io/twitter/follow/mucral?color=1da1f2&label=twitter&logo=twitter&style=plastic)](https://twitter.com/Mucral)
<h1 align="center">Management Server Minecraft</h1>
<p align="center">Install a Minecraft server on VM</p>

## Getting Started

### Installing VM on root
```
$ [apt yum] install wget java screen git -y
$ useradd minecraft --home /home/minecraft --shell /bin/bash
$ passwd minecraft (and enter password for minecraft user)
$ mkdir -p /opt/minecraft/instances
$ chown -R minecraft: /opt/minecraft
$ su - minecraft
$ mkdir ~/instances
$ cd ~/instances
$ git clone https://github.com/Mucral/Managament_script_mc.git
$ ./mng-srv-mc.sh
```
<!---
#### Running Locally Via [Github](https://github.com/YourUser/YourProject) (no install)
You can run this project locally by following these steps:
1. Clone/download the [repo](https://github.com/YourUser/YourProject)
2. Open terminal and cd into the project
3. Execute ```command_execution```

## Using the Application
1. Do this
    - Precision
2. And this
3. And also this

*Easy !*

### Configurations
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

## Video
If you need something visual to help you get started, [I made a video for the original release of this project](https://youtu.be/YourVideo); some things may be different but the same concepts still apply.

## Issues Using the Tool
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
-->

