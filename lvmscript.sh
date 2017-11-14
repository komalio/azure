#!/bin/bash
iqn=$1
blockIp=$2
sudo iscsiadm -m node -o new -T $1 -p $2:3260
sudo iscsiadm -m node -o update -T $1 -n node.startup -v automatic
sudo iscsiadm -m node -T $1 -p $2:3260 -l
sudo apt-get update
sudo apt-get install lvm2 -y
cd /
sudo pvcreate /dev/sda14
sudo pvcreate /dev/sdb
sudo vgcreate data-volume /dev/sda14
sudo vgextend data-volume /dev/sdb
sudo lvcreate -l 20 -n logical_volume data-volume
sudo mkfs -t ext4 /dev/data-volume/logical_volume
sudo mkdir /data
sudo chmod 777 /etc/fstab
sudo echo  "/dev/data-volume/logical_volume  /data  ext4  defaults  0  2" >> /etc/fstab
sudo chmod 644 /etc/fstab
sudo mount -a
sudo mount