echo Create mount point
sudo mkdir -p /mnt/backup
echo Mount network share
sudo mount -t nfs 192.168.10.10:/volume1/Backup /mnt/backup
echo Set permissions
sudo chmod 777 /mnt/backup
echo Write SD card image to network share
sudo dd if=/dev/mmcblk0p2 of=/mnt/backup/openhabpi.img bs=1M
