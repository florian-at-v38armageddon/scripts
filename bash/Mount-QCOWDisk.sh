#!/bin/bash
echo "Mounting the QCOW Disk image"
sudo modprobe nbd
sudo qemu-nbd -c /dev/nbd0 /path/to/your/disk.qcow2
sudo udisksctl mount -b /dev/nbd0p2
echo "QCOW Disk image mounted"
