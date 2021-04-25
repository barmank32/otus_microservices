#!/bin/bash -e

echo "Stop Docer and yc-container-daemon"
    sudo service docker stop
    sudo service yc-container-daemon stop

echo "Copy configs"
        sudo mkdir -p /volume/
        sudo cp -r -t /volume/ /tmp/loging/*

echo "Start Docer and yc-container-daemon"
    sudo service docker start
	sudo service yc-container-daemon start
