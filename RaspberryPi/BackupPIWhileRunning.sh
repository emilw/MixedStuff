sudo mkdir -p /mnt/backup
sudo mount -t nfs 192.168.10.10:/volume1/Backup /mnt/backup
sudo chmod 777 /mnt/backup
sudo dd if=/dev/mmcblk0p2 of=/mnt/backup/openhabpi.img bs=1M
