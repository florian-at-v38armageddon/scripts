#!/bin/bash
echo "Unmounting the QCOW Disk image"
sudo udisksctl unmount -b /dev/nbd0p2
sudo qemu-nbd -d /dev/nbd0
echo "QCOW Disk image unmounted"