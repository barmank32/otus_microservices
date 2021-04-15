#!/bin/bash -e
echo "Stop Docer and yc-container-daemon"
        sudo service docker stop
	sudo service yc-container-daemon stop

echo "Mount disk"
if (sudo file -sL /dev/disk/by-id/virtio-monitoring-data | grep -c ext4); then
        sudo mount -t ext4 /dev/disk/by-id/virtio-monitoring-data  /mnt/
else
        sudo mkfs.ext4 -F /dev/disk/by-id/virtio-monitoring-data
        sudo mount -t ext4 /dev/disk/by-id/virtio-monitoring-data  /mnt/
fi

echo "Copy configs"
        # sudo mkdir -p /mnt/grafana /mnt/prometheus /mnt/blackbox-exporter /mnt/alertmanager
        sudo cp -r -t /mnt/ /tmp/configs/*
        sudo chown -R 472:1 /mnt/grafana

echo "UMount disk"
        sudo umount /mnt/

echo "Start Docer and yc-container-daemon"
        sudo service docker start
	sudo service yc-container-daemon start