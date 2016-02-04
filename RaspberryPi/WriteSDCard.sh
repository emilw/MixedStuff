umount /dev/mmcblk0p1
sudo dd bs=4M if=2015-11-21-raspbian-jessie.img of=/dev/mmcblk0
sudo sync
