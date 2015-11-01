set -e
set -x

if [ -f /etc/disk_added_date ]
then
   echo "disk already added so exiting."
   exit 0
fi


sudo fdisk -u /dev/sdb <<EOF
n
p
1


t
8e
w
EOF

mkfs.ext4 /dev/sdb1
mkdir -p /var/hadoop/
mount /dev/sdb1 /var/hadoop
date > /etc/disk_added_date


echo "/dev/sdb1                    /var/hadoop                   ext4    defaults        0 0" >> /etc/fstab

