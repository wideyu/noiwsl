#!/bin/sh

mkdir -p /mnt/iso
mount -o loop $1 /mnt/iso
sqfs2tar "/mnt/iso$2" | pv > "$3"
