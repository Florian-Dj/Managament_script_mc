#!/usr/bin/env bash

settings=~/settings/settings-name.ini
ram=$(awk -F"=" '/ram/ {print $2}' $settings)

java -Xms${ram}M -Xmx${ram}M -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=60 -XX:G1MixedGCLiveThresholdPercent=35 -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -jar java-server.jar nogui
