#!/bin/sh

if [ ! -f $1 ]; then 
	echo "ERROR: $1 file not found"
else
	mkdir -p /mnt/iso
	mkdir -p /mnt/rfs
	mount -t iso9660 -o loop,ro $1 /mnt/iso
	mount -t squashfs -o loop,ro "/mnt/iso$2" /mnt/rfs
    tar -C /mnt/rfs -cf - ./ | pv -s $(du -sb /mnt/rfs | awk '{print $1}') > "$3"
fi
