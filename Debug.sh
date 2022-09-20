#! /bin/bash

qemu-system-i386 -fda "Build/NabOS.flp" -M smm=off -no-shutdown -no-reboot -d int -monitor stdio
